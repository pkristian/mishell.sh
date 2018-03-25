rm -rf ../testRepo
mkdir ../testRepo
cd ../testRepo
git init > /dev/null 2>&1
git remote add origin https://github.com/pkristian/mishell.sh.git > /dev/null 2>&1
git pull origin demo_alpha > /dev/null 2>&1
git checkout origin/demo_alpha > /dev/null 2>&1


bash ../mishell.sh \
	--branch demo_delta \
	--before "touch charlie" \
	--after "rm alpha" \
	--verbose \
	../testRepo

ls
