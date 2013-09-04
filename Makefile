update:
	rm -r ./.vimrc ./.vim
	cp -a ~/.vimrc ~/.vim ./

install:
	cp -a ./.vimrc ./.vim ~
