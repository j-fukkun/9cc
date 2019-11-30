#!/bin/bash

try(){
    expected="$1"
    input="$2"

    ./9cc "$input" > tmp.s
    gcc -o tmp tmp.s
    ./tmp
    actual="$?"

    if [ "$actual" = "$expected" ]; then
	echo "$input => $actual"
    else
	echo "$input => $expected expected, but got $actual."
	exit 1
    fi   
}

try 41 "a = 12 + 34 - 5;"
try 47 "a = 5 + 6 * 7;"
try 15 "a = 5 * (9 - 6);"
try 4 "a = (3 + 5) / 2;"
try 10 "a = -10+20;"
try 10 "a = --+10;"

try 0 'a = 0==1;'
try 1 'a = 42==42;'
try 1 'a = 0!=1;'
try 0 'a = 42!=42;'

try 1 'a = 0<1;'
try 0 'a = 1<1;'
try 0 'a = 2<1;'
try 1 'a = 0<=1;'
try 1 'a = 1<=1;'
try 0 'a = 2<=1;'

try 1 'a = 1>0;'
try 0 'a = 1>1;'
try 0 'a = 1>2;'
try 1 'a = 1>=0;'
try 1 'a = 1>=1;'
try 0 'a = 1>=2;'

try 10 'a = 10;'
try 5 'hoge = 5;'
try 15 'return 10+5;'
try 10 'a = 10; if(a <= 10) a = 10;'
try 10 'a = 0; b = 0; for(a = 0; a < 10; a = a + 1) b = b + 1;'
try 10 'a = 0; b = 0; hoge = 10; for(a = 0; a < 10; a = a + 1){ b=b+1; hoge = b + a;} a = 10;'


echo OK
