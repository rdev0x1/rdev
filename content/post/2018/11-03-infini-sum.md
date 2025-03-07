---
title: "1+2+3+4+5+...=-1/12 ????"
author: "Ramon Dev"
date: "2018-11-03T14:53:25Z"
draft: false
categories: [ "science" ]
tags: [ "maths" ]
mathjax: true
---

<script type="text/javascript"
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/3.2.2/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>

A few months ago I found an intersting youtube video explaining why we have $$\sum\_{n=1}^{\infty} n = \frac{-1}{12}$$ .<br>
Wait .... is it possible that the sum of positive number to equal to:

- a negative value ? :astonished:
- a fractional number ? :dizzy_face:

I don't think so, but let's dig into this.

Here is the video I'm talking about:<br>
<iframe width="560" height="315" src="https://www.youtube.com/embed/xqTWRtNDO3U" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Okay ... so let's compute 
$$
\sum\_{n=1}^{\infty} n
$$

1st approcah: how you are supposed to compute it
==================

$$
\begin{align}
  \sum\_{n=1}^{x} n & = \left(\frac{x(x+1)}{2}\right) \newline 
  \sum\_{n=1}^\infty x & = \lim\limits_{x \to \infty} \dfrac{x(x+1))}{2} = \infty
\end{align}
$$

Voila ! Done in one line.<br>
But if mathematicians are not that stupid, and they were working on this subject, and you will see, it is more interstingthan expected. 

So let's try to compute again this sum in other way.

2nd not rigourous approach
=============

Now we will use here the heuristic shown in the french video.
Let's start by computing A with

$$
\begin{align}
    A & = 1-1+1-1+1-... \newline
    A & = 1 - (1-1+1-1+...) \newline
    A & = 1 - A \newline
    A & = \frac{1}{2}
\end{align}
$$

And now let's compute B:

$$
\begin{align}
    B & = 1-2+3-4+5-... \newline
    B & = 1 - (2-3+4-5+...) \newline
    B & = 1-B-A \newline
    B & = \frac{1-A}{2} \newline
    B & = \frac{1}{4}
\end{align}
$$

Finally:
$$
\begin{align}
  S & = \sum\_{x=1}^\infty x \newline
  S & = 1+2+3+4+5+... \newline
  S - B & = (1+2+3+4+5+...) - (1-2+3-4+5-...) \newline
  S - B & = 2(2+4+6+8+...) \newline
  S - B & = 4(1+2+3+4+5+...) \newline
  S - B & = 4S \newline
  S & = \frac{-B}{3} \newline
  S & = \frac{-1}{12}
\end{align}
$$

So we got $\sum\_{n=1}^\infty n = \frac{-1}{12}$ <br>
But is this calculation matematicaly correct ? Well ... I'm afraid not:<br>
with divergent series we are not allowed to permute element we want to add to.
  So $x+y+z \neq z+x+y$ <br>
Therefore, what we did at line 4, 8 and 15 is wrong.<br>
That's why Abel said: *"Divergent series are the invention of the devil, and it is shameful to base on them any demonstration whatsoever"*.

Abel convergence approach
===================

Here we will use Riemann's zeta function with Abel convergence to compute $\sum\_{n=1}^{\infty} n$<br> 

The issue here is that our sum is divergent. However in mathematic, we can find an another sum method M that extend the sum methods Σ that we are used to use on simple convergent series.
This is based on Abel's theorem which states that power series relates a limit of a power series to the sum of its coefficients. [More information on divergent series here](https://en.wikipedia.org/wiki/Divergent_series), and on [Abel theorem here](https://en.wikipedia.org/wiki/Abel%27s_theorem)

<!--
[comment]: # (
We define Abel summation as
$$
\begin{align}
 A(a_n) & = \lim\limits_{x \to 1^-} \sum\_{n=0}^{\infty} a_n x^n
\end{align}
$$
)



[comment]: # (
I saw this in [askamathematician.com](https://www.askamathematician.com/2017/11/q-how-does-12345-112-make-any-sense/) and used this [wikipedia](https://en.wikipedia.org/wiki/1_−_2_%2B_3_−_4_%2B_⋯), but it seems wrong to me. I am not a mathematician, so I maybe missed something, so I did the calculation in my own way.<br>
Let's start as they did in wikipedia.
)
-->

Firstly the Riemann's zeta function is defined as:
$$
\begin{align}
\zeta(x) & = \sum\_{n=1}^\infty \frac{1}{n^x}
\end{align}
$$

This function is defined for all value of x>1. (Re(x)>1 if you use complex number).
You can check that if x=-1 then we are back to our sum 1+2+3+4+...<br> 
We can however use the zeta function because it can be analytically continued for all value of $x \neq 1$
$$
\begin{align}
\zeta(x) & = \frac{1}{1^x} + \frac{1}{2^x} + \frac{1}{3^x} + ... \label{zeta1} \newline
\frac{1}{2^{(x-1)}}  \zeta(x) & = \frac{1}{2^{x-1}} + \frac{1}{2^{x-1}2^x} + \frac{1}{2^{x-1}3^x} + ... \newline
\frac{1}{2^{(x-1)}}  \zeta(x) & = \frac{2}{2^x} + \frac{2}{2^x 2^x} + \frac{2}{2^x 3^x} + ... \newline
\frac{1}{2^{(x-1)}}  \zeta(x) & = \frac{2}{2^x} + \frac{2}{4^x} + \frac{2}{6^x} + ... \label{zeta2} \newline
\end{align}
$$

Let's substract \ref{zeta2} from \ref{zeta1}

$$
\begin{align}
\zeta(x) - \frac{1}{2^{(x-1)}}  \zeta(x) & = \frac{1}{1^x} + \frac{1}{2^x} - \frac{2}{2^x} + \frac{1}{3^x} + \frac{1}{4^x} - \frac{2}{4^x} ... \newline
(1 - \frac{1}{2^{(x-1)}})  \zeta(x) & = 1 - \frac{1}{2^x} + \frac{1}{3^x} - \frac{1}{4^x} + ... \newline
(1 - \frac{1}{2^{(x-1)}})  \zeta(x) & = \sum\_{n=1}^\infty \frac{(-1)^{(n+1)}}{n^x} \newline
\end{align}
$$

Let's fix x=-1 to return back to our sum 1+2+3+4+... and then let's add y variable with y=1
$$
\begin{align}
 -3 \zeta(-1) & = 1 - 2 + 3 - 4 .... \label{2ndequation} \newline
 -3 \zeta(-1) & = 1 - 2y + 3y^2 - 4y^3 ....  \newline
\end{align}
$$

According to Euler the result of this sum 1 - 2 + 3 -4 ... equal to $\frac{1}{4}$. This is based on what we call today Abel summation. So $\zeta(-1)=\frac{-1}{12}$. But let's check that.<br>
This is a well known taylor expansion:

$$
\begin{align}
 1 - 2y + 3y^2 - 4y^3 .... + (-n)^{(n-1}) y^{(n-1)} & = \frac{1}{(1+y)^2} \label{taylorequ} \newline
\end{align}
$$

So we can now check that when y=1 then we indeed got 1/4

$$
\begin{align}
 \lim_{y \to 1^-} \frac{1}{(1+y)^2} & = \frac{1}{4}
\end{align}
$$

Now, time to check if the taylor equation is correct<br>
The taylor serialisation of f(y) at y=a is defined as:

$$
\begin{align}
 f(a) + f^{(1)}(y-a) + \frac{f^{(2)}}{2!}(y-a)^2 + .... + \frac{f^{(n)}}{n!}(y-a)^n \label{taylor} \newline
\end{align}
$$

Here is the result for a=1 and a=0

$$
\begin{align}
 f(y) & = \frac{1}{(1+y)^2} \newline
 f^{(1)}(y) & = \frac{-2}{(1+y)^3} \newline
 f^{(2)}(y) & = \frac{6}{(1+y)^4} \newline
 f^{(n)}(y) & = \frac{(-1)^n(n+1)!}{(1+y)^{(n+2)}} \newline
 f(1) & = \frac{1}{(2)^2} \ && , f(0) = 1\newline
 f^{(1)}(1) & = \frac{-2}{(2)^3} \ && , f^{(1)}(0) = -2\newline
 f^{(2)}(1) & = \frac{6}{(2)^4} \ && , f^{(1)}(0) = 6\newline
 f^{(n)}(1) & = \frac{(-1)^n(n+1)!}{2^{(n+2)}} \ && , f^{(n)}(0) = (-1)^n(n+1)!\newline
\end{align}
$$

Let's apply taylor equation \ref{taylor} at a=0

$$
\begin{align}
 f(y) & = 1 - 2y + ....  (-1)^n(n+1)! \frac{y^n}{n!} \newline
 f(y) & = 1 - 2y + ....  (-1)^n(n+1)y^n \newline
 f(y) & = 1 - 2y + ....  (-1)^{(m-1)}(m)y^{m-1} \newline
 f(y) & = 1 - 2y + ....  (-m)^{(m-1)}y^{m-1} \newline
\end{align}
$$

This value matches with \ref{taylorequ}.<br>
Now let's apply taylor equation \ref{taylor} at a=1

$$
\begin{align}
 f(y) & = \frac{1}{4} - \frac{1}{4}(y-1) + ....  \frac{n!}{(2)^n n!}(y-1)^n \newline
\end{align}
$$

Let's continue our calculation. If we set y=1 we get 1/4

$$
\begin{align}
 f(y) & = \frac{1}{4} - \frac{1}{4}(1-1) + ....  \frac{n!}{(2)^n n!}(1-1)^n \newline
 f(y) & = \frac{1}{4} \newline
\end{align}
$$

Let's return to \ref{2ndequation}.
$$
\begin{align}
 -3 \zeta(-1) & = 1 - 2 + 3 - 4 .... \newline
 -3 \zeta(-1) & = \frac{1}{4} \newline
 \zeta(-1) & = \frac{-1}{12} \newline
\end{align}
$$

Ok, we did found the expected result:

{{< alert_start >}}
$$
\begin{align}
 \sum\_{n=1}^\infty \frac{1}{n^x} & = \frac{-1}{12} \newline
\end{align}
$$
{{< alert_end >}}

So is really true that this sum equal to -1/12 ??
===================

Well ... you know that you won't end with $\frac{-1 \text{€}}{12}$ if I gave you 1€, then 2€ on next second, then 3€, and so on for ever.<br>
But the value of $-\frac{1}{12}$ is used in some areas of string theory and quantum physics, not as a 'sum' but as a regularization of the series.

Therefore, the statement $\sum_{n=1}^{\infty} n = \frac{-1}{12}$ is not universally true. It holds under specific summation methods or in particular contexts.


