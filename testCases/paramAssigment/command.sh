bash ../mishell.sh \
	--print-vars \
	-vv \
	--remote r_emote \
	--branch b_ranch \
	--before "echo \"ff\"" \
	--after "tee tree" \
	blah
