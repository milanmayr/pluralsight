FROM php:7.4-cli
# Get all basic updates
RUN apt update && apt upgrade -y
# Install wget, git, zsh
RUN apt install -y wget git zsh
# Install Oh-My-Zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
CMD [ "zsh" ]