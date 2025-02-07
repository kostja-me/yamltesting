set -e

ascii_art='________                     _________________
__  ___/________ _____ _____ ______  /___  __ \_____  __   _____________ _______ ___
_____ \ ___  __ \_  _ \_  _ \_  __  / __  /_/ /__  / / /   _  ___/_  __ \__  __ `__ \
____/ / __  /_/ //  __//  __// /_/ /  _  ____/ _  /_/ /___ / /__  / /_/ /_  / / / / /
/____/  _  .___/ \___/ \___/ \__,_/   /_/      _\__, / _(_)\___/  \____/ /_/ /_/ /_/
        /_/                                    /____/                                '


echo -e "$ascii_art"
echo "=> SpeedPy.com Django-based Boilerplate requires Docker installed."

# Check Git
if command -v git &> /dev/null; then
    echo "Git is installed ($(git --version))"
else
    echo "Error: Git is not installed"
    exit 1
fi

# Check Docker
if command -v docker &> /dev/null; then
    echo "Docker is installed ($(docker --version))"
else
    echo "Error: Docker is not installed"
    exit 1
fi

echo "All required tools are installed"

echo "Selecting the clone target path:"
target_path="project"

while [ -e "./$target_path" ]; do
    target_path="project_$(( RANDOM % 1000 ))"
done

echo "Using path: $target_path"

echo "Cloning install scripts:"
git clone -q https://gitlab.com/speedpycom/speedpycom-standard.git $target_path >/dev/null
cd $target_path
if [[ $SPEEDPYCOM_REF != "master" ]]; then
	git fetch -q origin "${SPEEDPYCOM_REF:-master}" && git checkout "${SPEEDPYCOM_REF:-master}"
fi
rm -rf .git
echo "Initializing the project starting..."
bash init.sh