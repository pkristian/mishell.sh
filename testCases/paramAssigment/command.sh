bash ../mishell.sh \
	--print-vars \
	-v \
	--remote r_emote \
	--branch b_ranch \
	--before "echo \"ff\"" \
	--after "tee tree" \
	blah
