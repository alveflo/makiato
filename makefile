PATH := ./node_modules/.bin:${PATH}

.PHONY : all

all : init build docs

init :
	npm install

build :
	coffee -o lib/ -c src/
	coffee -o __test__/ -c test/

docs :
	docco src/*.coffee
