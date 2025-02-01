set -e

ascii_art='________                     _________________
__  ___/________ _____ _____ ______  /___  __ \_____  __   _____________ _______ ___
_____ \ ___  __ \_  _ \_  _ \_  __  / __  /_/ /__  / / /   _  ___/_  __ \__  __ `__ \
____/ / __  /_/ //  __//  __// /_/ /  _  ____/ _  /_/ /___ / /__  / /_/ /_  / / / / /
/____/  _  .___/ \___/ \___/ \__,_/   /_/      _\__, / _(_)\___/  \____/ /_/ /_/ /_/
        /_/                                    /____/                                '


echo -e "$ascii_art"
echo "=> SpeedPy.com Django-based Boilerplate requires Docker installed."
echo -e "\nBegin installation (or abort with ctrl+c)..."

echo "Selecting the clone target path:"
target_path="project"

while [ -e "./$target_path" ]; do
    target_path="project_$(( RANDOM % 1000 ))"
done

echo "Using path: $target_path"

echo "Cloning install scripts:"
git clone https://gitlab.com/speedpycom/speedpycom-standard.git $target_path >/dev/null
if [[ $SPEEDPYCOM_REF != "master" ]]; then
	cd $target_path
	git fetch origin "${SPEEDPYCOM_REF:-stable}" && git checkout "${SPEEDPYCOM_REF:-stable}"
	cd -
fi

echo "Initializing the project starting..."
source $target_path/init.sh