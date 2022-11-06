# http://courses.missouristate.edu/kenvollmar/mars/Help/MarsHelpCommand.html

.data

usage: .asciiz "Usage: java -jar Mars4_5.jar arguments.s pa <arg1> <arg2> [arg3]... [argN]"
nb_arg_is: .asciiz "Le nombre d'arguments est "
arg1_is: .asciiz "\nLe premier argument est "
arg2_is: .asciiz "\nLe deuxieme argument est "

.text

__start:
move $t0 $a0 #t0 contient le nombre d'arguments
move $t1 $a1 #t1 contient l'adresse d'un tableau de pointeurs vers les arguments

blt $t0 1 PrintUsage # Erreur si argc < 1

la $a0 nb_arg_is
li $v0 4
syscall   # Affichage

move $a0 $t0
li $v0 1
syscall # print(argc)

la $a0 arg1_is
li $v0 4
syscall   # Affichage

lw $t2 ($t1)
la $a0 0($t2)
li $v0 4
syscall # print(argv[0])

# la $a0 arg2_is
# li $v0 4
# syscall   # Affichage

# lw $t2 4($t1)
# la $a0 0($t2)
# li $v0 4
# syscall # print(argv[1])

j Exit

PrintUsage:
la $a0 usage
li $v0 4
syscall
j Exit

Exit:
li $v0 10  # appel système 10 -> fin du programme
syscall

