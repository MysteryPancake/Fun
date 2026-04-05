//@title ANGELVISION CHALLENGE #4: Seaside @by MysteryPancake
setGainCurve(x => Math.pow(x,2))
$BOAT:n("<-4 -7 -6 -9>/2").scale("f:phrygian").clip(.4)
 .s("wt_digital").att(0.05).orbit(0).room(1).roomsize(6).distort(1).gain(.5)._punchcard()

$WAVES: s("brown").tremolo(.3).gain(1).tremskew(.5).room(.6)

$BARNACLES: s("white").tremolo(irand(15)).fast(16).velocity(rand)
  .hpf(15000)
  .lpf(rand.range(500,4000)).lpd(.02).lpenv(5)
  .lpq(12)
  .delay(rand.fast(3)).delaytime(rand).gain(.1)

$PIANO: note("<68 61 63>").s("piano").orbit(1).lpf(2000).room(.9).rsize(10)._punchcard()

$PIANO2: note("<65 61 68 63> 73".sub("<12 0>/8")).s("piano").orbit(2).lpf(4000).room(1).rsize(13).delay(.25)._punchcard()

$PIANO3: note("<[85,92] 85 84>*9").s("piano").orbit(3).room(.8).rsize(6)._punchcard()