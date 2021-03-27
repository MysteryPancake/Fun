#include <iostream>
#include <fstream>
#include <math.h>

using namespace std;

#define pi 3.14159265358979323846

typedef struct WAV_HEADER
{
	// RIFF header chunk
	uint8_t riff[4] = { 'R', 'I', 'F', 'F' };
	uint32_t wavSize;
	uint8_t wave[4] = { 'W', 'A', 'V', 'E' };

	// Format chunk
	uint8_t fmt[4] = { 'f', 'm', 't', ' ' };
	uint32_t fmtChunkSize = 16; // 16 for PCM audio
	uint16_t audioFormat = 1; // 1 for PCM audio
	uint16_t numChannels; // 1 = mono, 2 = stereo
	uint32_t sampleRate; // usually 44100
	uint32_t byteRate;
	uint16_t blockAlign;
	uint16_t bitDepth;

	// Data chunk
	uint8_t data[4] = { 'd', 'a', 't', 'a' };
	uint32_t dataChunkSize;

} wav_header;

float noteFreq(float n)
{
	return 440.0 * pow(2.0, floor(n) / 12.0);
}

// From https://www.shadertoy.com/view/llByWR
float sawtooth(float d, float x)
{
	return (1.0 - 2.0 * acos((1.0 - d) * -cos(x / 2.0)) / pi) * (2.0 * atan(sin(x / 2.0) / d) / pi);
}

// Time, base note, range, notes per second, mod
float arpeggiate(float t, float b, float r, float n, float m)
{
	return fmod(floor(t / n), m) * r + b;
}

// This code is from my shader https://www.shadertoy.com/view/WtByDR
float generateAudioSample(float time, bool rightChannel)
{
	float phaseOffset = 0.01;

	int numNotes = 5;

	bool section2 = fmod(floor(time / 16.0), 2.0) != 0.0;
	float bass = section2 ? arpeggiate(time, 0.0, 2.0, 2.0, 2.0) : arpeggiate(time, 0.0, 3.0, 2.0, 2.0);
	float low = section2 ? arpeggiate(time, 12.0, 2.0, 2.0, 2.0) : arpeggiate(time, 12.0, 3.0, 2.0, 2.0);
	float mid = section2 ? arpeggiate(time, 12.0, 2.0, 2.0, 4.0) : arpeggiate(time, 16.0, 2.0, 1.0, 4.0);
	float high = section2 ? arpeggiate(time, 24.0, 2.0, 2.0, 2.0) : arpeggiate(time, 24.0, 3.0, 2.0, 2.0);
	float higher = section2 ? arpeggiate(time, 36.0, 2.4, 0.25, 4.0) : arpeggiate(time, 28.0, 2.0, 1.0, 4.0);
	
	float notes[] = { bass, low, mid, high, higher };
	float amplitudes[] = { 1.2, 1.0, 1.2, 0.6, 0.3 };
	
	float sample = 0.0;
	
	for (int i = 0; i < numNotes; i++)
	{
		float repeat = fmod(time, 0.25) * (5.0 - cos(time) * 2.0);
		if (i == 0)
		{
			repeat = fmod(time, 0.125) * (2.0 - cos(time));
		}
		repeat = min(repeat, (float)(0.7 + cos(time * 0.25) * 0.3));
		float offset = rightChannel ? cos(i) * phaseOffset : sin(i) * phaseOffset;
		sample += sawtooth(repeat, (time + offset) * noteFreq(notes[i])) * amplitudes[i];
	}
	return sample / numNotes;
}

uint16_t floatTo16Bit(float sample)
{
	float clamped = max((float)-1.0, min(sample, (float)1.0));
	uint16_t scaled = clamped < 0.0 ? clamped * 0x8000 : clamped * 0x7FFF;
	return scaled;
}

int main()
{
	// Make sure this is 44
	if (sizeof(wav_header) != 44) {
		cout << "Header wrong size, got " << sizeof(wav_header) << '\n';
		return 1;
	}

	// 16-bit stereo wav file
	uint16_t bitDepth = 16;
	uint16_t numChannels = 2;
	uint32_t sampleRate = 44100;
	uint32_t numSeconds = 240;
	uint32_t sampleCount = sampleRate * numSeconds;
	uint32_t bytesPerSample = bitDepth / 8;
	uint16_t blockAlign = numChannels * bytesPerSample;

	wav_header wavData;
	wavData.wavSize = 36 + sampleCount * bytesPerSample;
	wavData.numChannels = numChannels;
	wavData.sampleRate = sampleRate;
	wavData.byteRate = sampleRate * blockAlign;
	wavData.blockAlign = blockAlign;
	wavData.bitDepth = bitDepth;
	wavData.dataChunkSize = sampleCount * bytesPerSample;

	// Create new wav file
	ofstream wav("sickbeat.wav", ios::binary);
	// Make sure it worked
	if (!wav) {
		cout << "File is fucked\n";
		return 1;
	}

	// Write header info
	wav.write(reinterpret_cast<const char*>(&wavData), sizeof(wavData));

	// Write actual data
	for (int i = 0; i < sampleCount; i++)
	{
		float time = (float)i / (float)sampleRate;
		// Calculate left and right samples
		uint16_t leftSample = floatTo16Bit(generateAudioSample(time, false));
		uint16_t rightSample = floatTo16Bit(generateAudioSample(time, true));
		// Interleave left and right samples
		wav.write(reinterpret_cast<const char*>(&leftSample), sizeof(leftSample));
		wav.write(reinterpret_cast<const char*>(&rightSample), sizeof(rightSample));
	}
	
	wav.close();

	return 0;
}