async function purgeMessages(count, channel, logChannel) {
	const messages = await channel.fetchMessages({ limit: count }).catch(console.error);
	for (const message of messages.values()) {
		await logChannel.send(message.content).catch(console.error);
		await message.delete().catch(console.error);
	}
}
