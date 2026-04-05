// @title Louis Cole - Thinking
// @by MysteryPancake

setcpm(112/4)

let drums = sound("<[~ hh ~] [hh ~]>*16")
 .bank('tr626')
 .gain(rand.range(.3,.9))
 .punchcard()

let kick = sound("<bd ~ ~ ~ ~ sd ~ ~ ~ ~ ~ ~ ~ sd ~ ~>*16")
  .bank('linn9000')
  .postgain(1)
  .distort(2)

let chords = note(`<
[c4, e4, g4] - [c4, e4, g4] - [c4, e4, g4] - -
[f#4, d4, a3] - [f#4, d4, a3] - a4 [f#4, d4, a3] - [f#4, d4, a3] -
[b3, e4, g4] - [b3, e4, g4] - [b3, e4, g4] - -
[f#4, d4, a3] - [f#4, d4, a3] - d5 [f#4, d4, a3] - [f#4, d4, a3] -
[c4, e4, g4] - [c4, e4, g4] - [c4, e4, g4] - -
[f#4, d4, a3] - [f#4, d4, a3] - f#4 [f#4, d4, a3] - [f#4, d4, a3] -
[g#4, e4, b3] - [g#4, e4, b3] - [g#4, e4, b3] - -
[g#3, e4, b3] - [g#3, e4, b3] - b4 [g#3, e4, b3] - [g#3, e4, b3] -
>*16`)
.s("supersaw")
  .clip(rand.range(.5,1))
  .rel(rand.range(0,.3))
  .pan(rand.range(.3,.7))
  .distort(3)
  .postgain(.25)
  .cutoff(rand.range(4000,40000))
  .room(.6)
  .rsize(3)
  .rfade(.1)

let bass = note(`<
[a2, e3] - [a2, e3] - [a2, e3] - e2
[b2, f#3] b4 [b2, f#3] - - [b2, f#3] - [b2, g3] -
[b3, e3] - [b3, e3] - [b3, e3] - e3
[a3, e3] - [a3, e3] a2 - [a3, e3] - [a3, e3] -
[a2, e3] - [a2, e3] - [a2, e3] - -
[b2, f#3] - [b2, f#3] f#2 - [b2, f#3] - [b2, g3] -
[c#3, g#3] - [c#3, g#3] - [c#3, g#3] - -
[c#3, g#3] - [c#3, g#3] c#4 - [c#3, g#3] g#2 [c#3, a3] -
>*16`)
.s("supersaw")
  .clip(rand.range(.5,1))
  .rel(rand.range(0,.2))
  .distort(3)
  .postgain(.35)
  .cutoff(10000)
  .room(.6)
  .rfade(.1)
  .rsize(3)

$: drums
$: kick
$: chords
$: bass