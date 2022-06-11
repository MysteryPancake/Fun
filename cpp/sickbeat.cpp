#include <iostream>
#include <fstream>
#include <math.h>

using namespace std;

#define pi 3.14159265358979323846

struct WavHeader
{
	// RIFF header chunk
	const uint8_t riff[4] = { 'R', 'I', 'F', 'F' };
	uint32_t wavSize;
	const uint8_t wave[4] = { 'W', 'A', 'V', 'E' };

	// Format chunk
	const uint8_t fmt[4] = { 'f', 'm', 't', ' ' };
	const uint32_t fmtChunkSize = 16; // 16 for PCM audio
	const uint16_t audioFormat = 1; // 1 for PCM audio
	uint16_t numChannels = 1; // 1 = mono, 2 = stereo
	uint32_t sampleRate = 44100; // usually 44100
	uint32_t byteRate;
	uint16_t blockAlign;
	uint16_t bitDepth;

	// Data chunk
	const uint8_t data[4] = { 'd', 'a', 't', 'a' };
	uint32_t dataChunkSize = 0;
};

float noteFreq(float n)
{
	return 440.0f * pow(2.0f, floor(n) / 12.0f);
}

// From https://www.shadertoy.com/view/llByWR
float sawtooth(float d, float x)
{
	// Prevent sin divided by 0
	if (d == 0.0f) return d;
	// Smooth harsh attack
	float smoothAttack = min(1.0f, d * 50.0f);
	return (1.0f - 2.0f * acos((1.0f - d) * -cos(x / 2.0f)) / pi) * (2.0f * atan(sin(x / 2.0f) / d) / pi) * smoothAttack;
}

// Time, base note, range, notes per second, mod
float arpeggiate(float t, float b, float r, float n, float m)
{
	return fmod(floor(t / n), m) * r + b;
}

// This code is from my shader https://www.shadertoy.com/view/WtByDR
float generateAudioSample(float time, bool rightChannel)
{
	float phaseOffset = 0.01f;

	int numNotes = 5;

	bool section2 = fmod(floor(time / 16.0f), 2.0f) != 0.0f;
	float bass = section2 ? arpeggiate(time, 0.0f, 2.0f, 2.0f, 2.0f) : arpeggiate(time, 0.0f, 3.0f, 2.0f, 2.0f);
	float low = section2 ? arpeggiate(time, 12.0f, 2.0f, 2.0f, 2.0f) : arpeggiate(time, 12.0f, 3.0f, 2.0f, 2.0f);
	float mid = section2 ? arpeggiate(time, 12.0f, 2.0f, 2.0f, 4.0f) : arpeggiate(time, 16.0f, 2.0f, 1.0f, 4.0f);
	float high = section2 ? arpeggiate(time, 24.0f, 2.0f, 2.0f, 2.0f) : arpeggiate(time, 24.0f, 3.0f, 2.0f, 2.0f);
	float higher = section2 ? arpeggiate(time, 36.0f, 2.4f, 0.25f, 4.0f) : arpeggiate(time, 28.0f, 2.0f, 1.0f, 4.0f);
	
	float notes[] = { bass, low, mid, high, higher };
	float amplitudes[] = { 1.2f, 1.0f, 1.2f, 0.6f, 0.3f };
	
	float sample = 0.0f;
	
	for (int i = 0; i < numNotes; i++)
	{
		float repeat = fmod(time, 0.25f) * (5.0f - cos(time) * 2.0f);
		if (i == 0)
		{
			repeat = fmod(time, 0.125f) * (2.0f - cos(time));
		}
		repeat = min(repeat, (float)(0.7f + cos(time * 0.25f) * 0.3f));
		float offset = rightChannel ? cos(i) * phaseOffset : sin(i) * phaseOffset;
		sample += sawtooth(repeat, (time + offset) * noteFreq(notes[i])) * amplitudes[i];
	}
	return sample / numNotes;
}

int16_t floatTo16Bit(float sample)
{
	float clamped = max(-1.0f, min(sample, 1.0f));
	int16_t scaled = clamped < 0.0f ? clamped * 0x8000 : clamped * 0x7FFF;
	return scaled;
}

int main()
{
	// Make sure this is 44
	static_assert(sizeof(WavHeader) == 44, "Header wrong size");

	// 16-bit stereo wav file
	const uint16_t bitDepth = 16;
	const uint16_t numChannels = 2;
	const uint32_t sampleRate = 44100;
	const uint32_t numSeconds = 60;
	const uint32_t sampleCount = (uint32_t)((float)sampleRate * numSeconds);
	const uint32_t bytesPerSample = bitDepth / 8;
	const uint16_t blockAlign = numChannels * bytesPerSample;

	WavHeader header;
	header.wavSize = 36 + sampleCount * bytesPerSample;
	header.numChannels = numChannels;
	header.sampleRate = sampleRate;
	header.byteRate = sampleRate * blockAlign;
	header.blockAlign = blockAlign;
	header.bitDepth = bitDepth;
	header.dataChunkSize = sampleCount * blockAlign;

	// Create new wav file
	ofstream wav("sickbeat.wav", ios::binary);
	// Make sure it worked
	if (!wav) {
		cout << "File is corrupted\n";
		return 1;
	}

	// Write header info
	wav.write(reinterpret_cast<const char*>(&header), sizeof(header));

	// Write actual data
	for (uint32_t i = 0; i < sampleCount; i++)
	{
		float time = (float)i / (float)sampleRate;
		// Calculate left and right samples
		int16_t leftSample = floatTo16Bit(generateAudioSample(time, false));
		int16_t rightSample = floatTo16Bit(generateAudioSample(time, true));
		// Interleave left and right samples
		wav.write(reinterpret_cast<const char*>(&leftSample), sizeof(leftSample));
		wav.write(reinterpret_cast<const char*>(&rightSample), sizeof(rightSample));
	}
	
	wav.close();

	return 0;
}