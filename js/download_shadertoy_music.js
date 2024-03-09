function interleave(inputL, inputR) {
	const length = inputL.length + inputR.length;
	const result = new Float32Array(length);
	let index = 0;
	let inputIndex = 0;
	while (index < length) {
		result[index++] = inputL[inputIndex];
		result[index++] = inputR[inputIndex];
		inputIndex++;
	}
	return result;
}

function floatTo16Bit(output, offset, input) {
	for (let i = 0; i < input.length; i++, offset += 2) {
		const s = Math.max(-1, Math.min(1, input[i]));
		output.setInt16(offset, s < 0 ? s * 0x8000 : s * 0x7FFF, true);
	}
}

function floatTo32Bit(output, offset, input) {
	for (let i = 0; i < input.length; i++, offset += 4) {
		output.setFloat32(offset, input[i], true);
	}
}

function writeString(view, offset, str) {
	for (let i = 0; i < str.length; i++) {
		view.setUint8(offset + i, str.charCodeAt(i));
	}
}

function encodeWAV(samples, format, sampleRate, numChannels, bitDepth) {
	const bytesPerSample = bitDepth / 8;
	const blockAlign = numChannels * bytesPerSample;
	const buffer = new ArrayBuffer(44 + samples.length * bytesPerSample);
	const view = new DataView(buffer);
	writeString(view, 0, "RIFF");
	view.setUint32(4, 36 + samples.length * bytesPerSample, true);
	writeString(view, 8, "WAVE");
	writeString(view, 12, "fmt ");
	view.setUint32(16, 16, true);
	view.setUint16(20, format, true);
	view.setUint16(22, numChannels, true);
	view.setUint32(24, sampleRate, true);
	view.setUint32(28, sampleRate * blockAlign, true);
	view.setUint16(32, blockAlign, true);
	view.setUint16(34, bitDepth, true);
	writeString(view, 36, "data");
	view.setUint32(40, samples.length * blockAlign, true);
	if (format === 1) {
		floatTo16Bit(view, 44, samples);
	} else {
		floatTo32Bit(view, 44, samples);
	}
	return view;
}

function bufferToFile(name, buffer, float32) {
	let interleaved;
	const numChannels = Math.min(buffer.numberOfChannels, 2);
	if (numChannels === 2) {
		interleaved = interleave(buffer.getChannelData(0), buffer.getChannelData(1));
	} else {
		interleaved = buffer.getChannelData(0);
	}
	const view = encodeWAV(interleaved, float32 ? 3 : 1, buffer.sampleRate, numChannels, float32 ? 32 : 16);
	return new File([view], name + ".wav", { type: "audio/wav" });
}

gShaderToy.mEffect.mPasses.forEach((buffer, i) => {
	if (buffer.mBuffer) {
		const name = `audio${i}`;
		const file = bufferToFile(name, buffer.mBuffer, true);
		const link = document.createElement("a");
		link.href = window.URL.createObjectURL(file);
		link.download = `${name}.wav`;
		link.click();
		window.URL.revokeObjectURL(file);
	}
});