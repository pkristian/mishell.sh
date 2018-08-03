bash ../mishell.sh \
	--branch demo_delta \
	--before "touch charlie" \
	--after "rm alpha" \
	../testRepo

ls
