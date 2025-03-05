---
title: "Intel interview"
author: "Ramon Dev"
date: "2017-03-15T14:53:25Z"
output: #html_document
  blogdown::html_page:
    highlight: pygments
params:
  theme: solarized-dark
categories: [ "info" ]
tags: [ "Intel", "interview", "c" ]
---


![alt text](intel_logo.jpg "Logo Intel")

Do you want to work for Intel ?<br>
If you are curious, here is the test I did.
You are supposed to do it online and you have 2 hours.<br>
Unfortunately I don't remember exactly the question I had.

Training test
=================

Find a  palindrome in an array

- A is the array
- N is the size

There were other special condition that I forgot, sorry.

Example:<br>
A={-1,3,-4,5,1,-6,2,1};<br>
You can return 1 because<br>
-1 = -4+5+1-6+2+1<br>
If there is several solutions, then you can choose which to return.

<pre><code class="c">
prototype
int solution(int A[], int N) {
}
</code></pre>

1st exercise:
=============
N is a number between 1 and ... I dont remember which number.
The goal is to find the highest power k, which fulfill this condition:
N should be divisible by 2 power k

prototype of the function

<pre><code class="C">
int solution(int N) {
}
</code></pre>

Example:
N=24, then the function should returns 3, because  2^3 = 8 and 8 is the highest number which divide  24.
Below is my solution

<pre><code class="C">
int solution(int N) {
	int p = 0;
	int _p=0;
	int _v=1;

	do {
		if (_v>N) {
		       return p;
		}

		if (N%_v==0) {
			p=_p;
		}
		_v = _v<<1;
		_p++;
	}while(1);
}
</code></pre>

2nd exercise:
=============
You want to paint a wall.<br>
You have an array A of number between 1 and 100000000.<br>
N is the size of this array<br>

Example A={1,3,2,1,2,1,5,3,3,4,2};<br>

A is the height of the paint.<br>

<canvas id="intel_exo2" width="400" height="200"></canvas>
<script src="intel_interview_exo2.js"></script>

The goal is to find the number of horizontal painting line we need to do.<br>
In our example, the answer is 9<br>
because for the first horizontal level (a in my schematic), you can do it in one
time. You need then 3 times for b, etc ...<br>
a -> 1<br>
b-> 3<br>
c -> 2<br>
d -> 2<br>
e-> 1<br>
--> total : 9<br>

So our function should return 9 in this example.<br>

We cannot returns more than  1000000000. If its the case, then we should return -1<br>

Here is an another example: A={1,1,1,1}<br>
Here the function should return 1 because we can do it ine one shot.<br>

prototype of the function
<pre><code class="C">
int solution(int A[], int N) {
}
</code></pre>

My solution:

<pre><code class="C">
int solution(int A[], int N) {
	int i;
	int n;

	if (N==0) {
		return 0;
	}
	n=A[0];

	for(i=1; i < N; i++)
	{
		if (A[i] > A[i-1]) {
			n += A[i] - A[i-1];
		}
		if (n>1000000000){
			return -1;
		}
	}
	return n;
}
</code></pre>


3rd exercise
=============

We have a lift of M levels<br>
We have N person which want to take this lift.<br>
Person are taking the lift in order.<br>
The lift can take a maximum of X person and Y kg<br>
The weight of persons are in an array A.<br>
Theses persons want to go to a level which is saved in an array B<br>

When the lift go to a level, it will always return down to the ground<br>

You need to create a function which return the number of lift stop without forgetting the last stop to the ground at the end.<br>

Example<br>
    A={60,80,40};<br>
    B={2,3,5};<br>
    M=5<br>
    Y=200kg<br>
    N=3<br>
    X=2<br>
We should return  5, because<br>
The lift take the first 2 persons, and go to level 2 and then 3. (2 stops)<br>
The lift go then to the ground. (1 stop)<br>
we go to level 5 for the last person. (1 stop)<br>
We return back to the ground (1 stop)<br>
total = 5 stops.<br>

Don't forget that 2 or more people may stop to the same level.<br>

prototype of the function:<br>

<pre><code class="C">
int solution(int A[], int B[], int N, int M, int X, int Y) {
}
</code></pre>

My solution:

<pre><code class="C">

int solution(int A[], int B[], int N, int M, int X, int Y)
{
	// write your code in C99
	int i;
	int j,k;
	int c=0;
	int p=0;
	char *T;

	if (N==0) {
		return 0;
	}
	T=(char*)alloca(M);

	for(i=0; i < N;)
	{
		p=0;
		memset(T,0,M);
		for(p=0,k=0,j=i; j-i < X && j < N; j++) {
			p += A[j];
			if (p > Y) {
				break;
			}
			k++;
			if (T[B[j]-1] == 0) {
				c++;
				T[B[j]-1] = 1;
			}
		};
		c++;
		i+=k;
	}

    return c;
}

</code></pre>
