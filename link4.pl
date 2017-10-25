#!/usr/bin/perl
#
#   Packages and modules
#
use strict;
use warnings;
use version;         our $VERSION = qv('5.16.0');   # This the version of Perl to be used

# LINK 4 v3
# Features include
# +Choosable game pieces
# +Tells you where the last piece is placed
# +Tells you how the game ended
# +Copyright free hahahahahaha probably not

# 7x6 LINK 4
my @board = (['0','0','0','0','0','0','0'],['0','0','0','0','0','0','0'],['0','0','0','0','0','0','0'],['0','0','0','0','0','0','0'],['0','0','0','0','0','0','0'],['0','0','0','0','0','0','0']);
my $max_rows = 7;
my $max_columns = 6;
my $gameWin = 0;
my $gameEnd = 0;
my $input="";
my $firstTime = 1;
my $c1 = 5;
my $c2 = 5;
my $c3 = 5;
my $c4 = 5;
my $c5 = 5;
my $c6 = 5;
my $c7 = 5;
my $notanswered = 1;
my $x, my $y;
# player icons
my $p1 = "A";
my $p2 = "B";
my $stamp = "";
my $inarow = 0;
my $hash4 = 0;
my $wrongInput = 0;
my $winCondition = "No Contest";
my $boardFill = 0;
my $clear = "clear";
# $board[column][row]
# r
#c0|1|2|3|4|5|6|
# 1| | | | | | |
# 2
# 3
# 4
# 5
my $LINUX = 0;
if ($^O eq 'linux') { $LINUX = 1;}
if ($LINUX) {
    print "It's Linux";
} else {
    $clear = "cls";
}
sub CheckWin{
    #takes in the $input for x, takes the column count for y
    my @list = @_;
    $x = $_[0]-1;
    $y = $_[1];
    print "The player ".$stamp." dropped their piece in [c",$x+1,",r";
    print 5-$y+1,"] \n";
    #check top down
    #calculate the height of current placed piece
    #5-$y+1 if y=5 it will become 1, [y1=4,y2=2] etc.. where the result is the height
    #$input-1, results in the actual array row
    if (5-$y+1 >= 4){ #if the height of the current stack is 4 or more, we will check for a vertical 4 in a row
        # print $board[$y][$x].$board[$y+1][$x].$board[$y+2][$x].$board[$y+3][$x];
        if ($board[$y][$x] eq $board[$y+1][$x] &&
            $board[$y][$x] eq $board[$y+2][$x] &&
            $board[$y][$x] eq $board[$y+3][$x]){
            $winCondition = "4 in a row vertically!";
            $gameWin = 1;
        }
        $hash4 = 1;
    }
    if ($hash4){ #start checking diagonally after height has reached 4 and hasn't won
        #check diagonally bl to tr
        $inarow = 1;
        #check to the down-left
        for my $i(1..5){
            if ($x-$i >= 0 && $y+$i <= 5){
                if ($board[$y][$x] eq $board[$y+$i][$x-$i]){
                    $inarow++;
                } else {
                    last;
                }
            } else {
                last;
            }
        }
        #check to the up-right
        for my $i(1..5){
            if ($x+$i <= 6 && $y-$i >= 0){
                if ($board[$y][$x] eq $board[$y-$i][$x+$i]){
                    $inarow++;
                } else {
                    last;
                }
            } else {
                last;
            }
        }
        if ($inarow >= 4){
            $winCondition =  "with ".$inarow." in a row diagonally!";
            $gameWin = 1;
        }
        #check diagonally tl to br
        $inarow = 1;
        #check to the up-left
        for my $i(1..5){
            if ($x-$i >= 0 && $y-$i >= 0){
                if ($board[$y][$x] eq $board[$y-$i][$x-$i]){
                    $inarow++;
                } else {
                    last;
                }
            } else {
                last;
            }
        }
        #check to the down-right
        for my $i(1..5){
            if ($x+$i <= 6 && $y+$i <= 5){
                if ($board[$y][$x] eq $board[$y+$i][$x+$i]){
                    $inarow++;
                } else {
                    last;
                }
            } else {
                last;
            }
        }
        if ($inarow >= 4){
            $winCondition =  "with ".$inarow." in a row diagonally!";
            $gameWin = 1;
        }
    }
    #check horizontally
    $inarow = 1;
    #check to the left
    for my $i(1..3){
        if ($x-$i >= 0){
            if ($board[$y][$x] eq $board[$y][$x-$i]){
                $inarow++;
            } else {
                last;
            }
        } else {
            last;
        }
    }
    #check to the right
    for my $i(1..3){
        if ($x+$i <= 6){
            if ($board[$y][$x] eq $board[$y][$x+$i]){
                $inarow++;
            } else {
                last;
            }
        } else {
            last;
        }
    }
    # print $inarow." in a row horizontally.\n";
    if ($inarow >= 4){
        $winCondition =  "with ".$inarow." in a row horizontally!";
        $gameWin = 1;
    }

}
system($clear);
print "LINK 4\n";
print "Flip a coin IRL :)\n";
print "Enter anything to continue\n";
chomp ($input = <>);
$input = "0";
while (length($input) != 1 || $input !~ /^[a-zA-Z]+$/ ){
    system($clear);
    $input = "0";
    print "\n";
    print "Player 1 enter a character for your game pieces; 1 character from the alphabet.\n";
    chomp ($input = <>);
}
$p1 = $input;
$input = "0";
while (length($input) != 1 || $input !~ /^[a-zA-Z]+$/){
    system($clear);
    if ($input eq "1"){
        print "er.. that's taken already\n";
    } else {
        print "\n"
    }
    $input = "0";
    print "Player 2 enter a character for your game pieces; 1 character from the alphabet.\n";
    chomp ($input = <>);
    if ($input eq $p1){
        $input = "1";
    }
}
$p2 = $input;


while (!$gameWin && !$gameEnd) {
    system($clear);
    if (!$firstTime){
        # player switcher
        if ($wrongInput){
            $wrongInput = 0;
        }
        elsif ($stamp eq "" || $stamp eq $p2){
            $stamp = $p1;
        } else {
            $stamp = $p2;
        }
        # piece placer
        if ($input eq 1){
            if ($c1 != -1){
                # print "You dropped it in the first row\n";
                $board[$c1][0] = $stamp;
                CheckWin($input,$c1);
                $c1--;
                $boardFill++;
            } else {
                 print "You dropped it in the first row but it couldn't fall into the slot.\n";
            }
        } elsif ($input eq 2){
            if ($c2 != -1){
                # print "You dropped it in the second row\n";
                $board[$c2][1] = $stamp;
                CheckWin($input,$c2);
                $c2--;
                $boardFill++;
            } else {
                print "You dropped it in the second row but it couldn't fall into the slot.\n";
            }
        } elsif ($input eq 3){
            if ($c3 != -1){
                # print "You dropped it in the third row\n";
                $board[$c3][2] = $stamp;
                CheckWin($input,$c3);
                $c3--;
                $boardFill++;
            } else {
                print "You dropped it in the third row but it couldn't fall into the slot.\n";
            }
        } elsif ($input eq 4){
            if ($c4 != -1){
                # print "You dropped it in the fourth row\n";
                $board[$c4][3] = $stamp;
                CheckWin($input,$c4);
                $c4--;
                $boardFill++;
            } else {
                print "You dropped it in the fourth row but it couldn't fall into the slot.\n";
            }
        } elsif ($input eq 5){
            if ($c5 != -1){
                # print "You dropped it in the fifth row\n";
                $board[$c5][4] = $stamp;
                CheckWin($input,$c5);
                $c5--;
                $boardFill++;
            } else {
                print "You dropped it in the fifth row but it couldn't fall into the slot.\n";
            }
        } elsif ($input eq 6){
            if ($c6 != -1){
                # print "You dropped it in the sixth row\n";
                $board[$c6][5] = $stamp;
                CheckWin($input,$c6);
                $c6--;
                $boardFill++;
            } else {
                print "You dropped it in the sixth row but it couldn't fall into the slot.\n";
            }
        } elsif ($input eq 7){
            if ($c7 != -1){
                # print "You dropped it in the seventh row\n";
                $board[$c7][6] = $stamp;
                CheckWin($input,$c7);
                $c7--;
                $boardFill++;
            } else {
                print "You dropped it in the seventh row but it couldn't fall into the slot.\n";
            }
        } elsif ($input eq "q"){
            # game quit
            while ($input ne "y" && $input ne "n") {
                system($clear);
                print "You wanna quit? y or n\n";
                chomp ($input = <>);
            }
            if ($input eq "y"){
                $gameEnd = 1;
            } else {
                system($clear);
                print "\n";
                $wrongInput = 1;
            }
        } else {
            print "I think you need to enter a number or enter q to quit\n";
            $wrongInput = 1;
        }
    } else {
        # intro
        $firstTime = 0;
        print "Welcome to the game, type a number to drop a piece to the corresponding\n"
    }
    # print board
    print "^1^2^3^4^5^6^7^\n";
    if ($boardFill == 42 && !$gameWin){
        $gameEnd = 1;
        $winCondition = "The board is full and nobody has won.";
    }
    if (!$gameWin && !$gameEnd){
        for my $i(0..5){#moves printing to the next row, there are 6 rows
            for my $j(0..6){
                print "|".$board[$i][$j];
            }
            print "|\n";
        }
        chomp ($input = <>);
    } else {
        # show end result
        system($clear);
        for my $i(0..5){
            for my $j(0..6){
                print "|".$board[$i][$j];
            }
            print "|\n";
        }
        print "Game Over\n";
        if ($gameWin){
            print $stamp." wins \n";
        }
        print $winCondition."\n";
    }
}
