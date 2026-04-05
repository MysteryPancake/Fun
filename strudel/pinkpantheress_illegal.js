// @title PinkPantheress - Illegal
// @by MysteryPancake

setcpm(141/4)

$: sound(`<
    bd ~ ~ ~ ~ bd ~ ~
    bd ~ ~ [~ bd] ~ bd ~ ~
>*8`).bank('9000').distort(2).postgain(.7)._scope()

$: sound(`<
    ~ ~ [sd, rim] ~ ~ ~ [sd, rim] ~
    ~ ~ [sd, rim] ~ ~ ~ [sd, rim] ~
>*8`).bank('compurhythm1000').distort(1).postgain(.7)._scope()

$: sound("<~ hh ~ hh ~ hh ~ [hh hh]>*8").bank('rm50').distort(1).postgain(.5).pan(rand.range(.2,.8))._scope()

$: note(`<
    [a#3,d#4,g4] ~ ~ ~ [a#3,d#4,g4] ~ ~ [a#3,d#4,g4]
    ~ ~ ~ ~ [a#3,d4,a4] ~ [a#3,d4,a4] ~
>*8`).s("supersaw").rel(.3).room(1).rsize(3).distort(.4).pan(rand.range(.3,.7)).postgain(.7)._punchcard()
$: note(`<
    [c1,c2] ~ ~ ~ [c1,c2] ~ ~ [c1,c2]
    ~ ~ ~ ~ [g1,g2] ~ [d1,d2] ~
>*8`).s("supersaw").rel(.3).room(1).rsize(3).distort(1).postgain(.8)._punchcard()

$s: note(`<
    ~ ~ ~ d5 d#5 [d5 c5] [~ c5] [c5 ~]
    c5 c5 c5 c5 c5 c5 ~ ~
    ~ ~ ~ d5 d#5 a#4 a#4 [c5 ~]
    c5 c5 d5 c5 c5 c5 ~ ~
    ~ ~ g5 ~ g4 a#4 d5 c5 ~
    c5 c5 c5 c5 c5 ~ ~
    ~ ~ g5 ~ g4 a#4 d5 c5 ~
    c5 [c5 d5] a#4 a#4 a#4 ~ ~
>*8`).s("gm_voice_oohs").distort(2).room(.3).rsize(3).postgain(.9).vib(8).vibmod(.1)._punchcard()

/*await samples('shabda/speech:my,name,is,pink,and,im,reel,lee,glad,to,meet,you,your,rec,commend,dead,me,by,some,people,hey,ooh,this,ill,eagle,it,feels')

$: s(`<
    ~ ~ ~ my name [is pink] ~ [and im]
    reel lee [glad to] ~ [meet you] ~ ~
    ~ ~ ~ ~ your rec commend ~ dead to me
    by some people ~ ~
    ~ ~ hey ~ ~ ooh ooh ooh ooh ~
    is this ill eagle ~ ~
    ~ ~ hey ~ ~ ooh ooh ooh ooh ~
    it feels ill eagle ~ ~ ~
>*8`).begin(.2).room(.2).rsize(3).postgain(4).cut(2).speed(`<
    ~ ~ ~ 1.25 1.55 [1.25 1] ~ [1.05 1.05]
    1.05 1.05 [1.05 1.05] ~ [1.05 1.05] ~ ~
    ~ ~ ~ ~ 1.25 1.6 1.25 ~ 1.05 1.05 1.05
    1.4 1.05 1.05 ~ ~
    ~ ~ 1.5 ~ ~ .8 1 1.45 1.2 ~
    1.2 1.2 1.2 1.2 ~ ~
    ~ ~ 1.5 ~ ~ .8 1 1.45 1.2 ~
    1.3 1.6 1.2 1.2 ~ ~ ~
>*8`)*/