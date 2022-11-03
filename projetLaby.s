# Données
.data
    RetChar: .asciiz "\n"
    Tableau: .asciiz "Tableau de taille: "
    Aladresse: .asciiz "à l'adresse: "
    espace: .asciiz " "
    

.text
.globl __start

__start:
# corps du programme ...
# ...
# ...
    # li $a1, 5
    # jal convertToBinary
    # li $a0, 8
    # move $a1, $v0
    # jal AfficheTableau

    # #Test de la fonction cell_lecture_bit
    # #$a0 : le bit i
    # #$a1 : Nombre dont on lit le bit
    # #$v1 : Sortie

    # li $a0, 0
    # li $a1, 12
    # jal convertToBinary
    # jal cell_lecture_bit
    # li $v0, 1
    # move $a0, $v1
    # syscall
    # move $a0, $v0
    # li $a1, 8
    # jal convertToDecimal
    # move $a0, $v0
    # li $v0, 1
    # syscall

    # #Test de la fonction cell_metre_bitA0 et cell_mettre_bitA1
    # #$a0 : Bit i
    # #$a1 : Entier n
    # #$v0 : Sortie
    # li $a0, 1
    # li $a1, 5
    # # jal cell_mettre_bit_a0
    # jal cell_mettre_bit_a1
    # move $a0, $v0
    # li $v0, 1
    # syscall

    # #Test de la fonction st_creer
    # #$a0 : taille maximal du tableau
    # #$v0 : Sortie
    # li $a0, 5
    # jal st_creer
    # lw $a0, 4($v0)         # 5 -> 0($v0) et 0 -> 4($v0)
    # li $v0, 1
    # syscall


    # #Test de la fonction st_est_vide
    # #$a0 : addresse du tableau
    # #$v0 : sortie, 1 si vide | 0 sinon
    # move $a0, $v0
    # jal st_est_vide
    # move $a0, $v0
    # li $v0, 1
    # syscall

    # #Test de la fonction st_est_pleine
    # #$a0 : addresse du tableau
    # #$v0 : sortie, 1 si pleine | 0 sinon

    # move $a0, $v0
    # jal st_est_pleine
    # move $a0, $v0
    # li $v0, 1
    # syscall

    # #Test de la fonction st_empiler
    # li $a0, 5               # la taille maximale du tableau
    # jal st_creer
    # move $s0, $v0           # l'addresse du tableau -> $s0
    # move $a0, $s0

    # li $a1, 3
    # jal st_empiler
    # li $a1, 4
    # jal st_empiler
    # li $a1, 6
    # jal st_empiler

    # #3, 4, 6 empilées dans notre tableau, créer par st_creer.

    # #On affiche le tableau après empilement
    # move $a1, $s0 
    # lw $a0, 4($a0)
    # addi $a0, $a0, 2
    # jal AfficheTableau

    # # Test de la fonction st_sommet
    # # $a0 : l'addresse du tableau
    # # $v0 : Sommet de la pile
    # move $a0, $s0
    # jal st_sommet

    # move $a0, $v0
    # jal AfficheEntier
    # # Test de la fonction st_depiler
    # # $a0 : l'addresse du tableau
    # move $a0, $s0
    # jal st_depiler

    # # # On affiche le tableau après depilement
    # move $a1, $s0 
    # lw $a0, 4($a0)
    # addi $a0, $a0, 2
    # jal AfficheTableau


    # Test de la fonction creerLaby
    # $a0 : taille du laby. ex $a0 = 5
    li $a0, 5
    jal creerLabyrinthe


    # Test de la fonction afficheLaby
    # $a0 : taille du laby
    # $a1 : Adresse du laby
    move $s0, $v0
    move $a1, $s0
    jal afficheLaby

    # Test de la fonction getValueCellIndiceI
    # $a0 : indice i
    # $a1 : addresse du laby
    # $v0 : la valeur se trouvant à l'indice i
    li $a0, 3
    jal getValueCellIndiceI
    move $a0, $v0
    jal AfficheEntier

    # Test de la fonction setValueCellIndiceI
    # $a0 : l'indice i [0, N*N]
    # $a1 : addresse du laby
    # $a2 : nouvelle valeur à mettre
    li $a0, 3
    move $a1, $s0
    li $a2, 16
    jal setValueCellIndiceI


    # Affiche le laby après la avoir mis 16 à l'indice 3
    li $a0, 5
    jal afficheLaby





j Exit # saut a la fin du programme

procedure:
# procedure...
# ...

################ Fonction convertToBinary
# Paramètre : 
#       $a1 : la valeur à convertir
#
# Pré-conditions : 
#       $a1 entre 0 et 127
#
# Sortie : 
#       $v0 : addresse (en octet) du premier entier du tableau 
convertToBinary:
    #Prologue
    addi $sp, $sp, -16
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)
    sw $s0, 12($sp)

    #corps de la fonction
    li $a0, 32  # 4*8 Nombre d'octet à allouer -> $a0
    li $v0, 9
    syscall

    # Initialisation du tableau à 0
    move $s0, $v0       # addresse du premier élément du tableau -> $s0
    li $t2, 0           
    li $t4, 4
    li $t1, 8           # taille du tableau -> $t1
    li $t0, 0           # itérateur
    loop1 : bge $t0, $t1 next
        mul $t5, $t4, $t0   # t5 = i*4
        add $t5, $s0, $t5   # t5 = s0 + i*4
        sw $t2, 0($t5)

        addi $t0, $t0, 1
        j loop1
    
    # Initialisation du tableau de bits à 0 terminé [0, 0, 0, 0, 0, ,0, 0, 0]
    next: 
        # On parcours le tableau de la fin
        li $t2, 2
        li $t0, 7
        loop2: bltz $t0, fin
            mul $t5, $t4, $t0
            add $t5, $s0, $t5
            div $a1, $t2

            mflo $a1    # le quotient $a1 = $a1 / 2
            mfhi $t3    # le reste $t3 = $a1 % 2
            
            sw $t3 0($t5)

            addi $t0, $t0, -1
            j loop2



    #epilogue
    fin:
        lw $ra, 0($sp)
        lw $a0, 4($sp)
        lw $a1, 8($sp)
        lw $s0, 12($sp)
        addi $sp, $sp, 16

        jr $ra

###########################################################################

################# Fonction convertToDecimal
# Entrées :
#   $a0 : addresse du tableau
#   $a1 : Taille du tableau, soit 8 pour le nombre total des bits
#
#
# Pré-conditions
# Sorties : 
#    $v0 : la valeur en decimal
convertToDecimal:
    # prologue
    addi $sp, $sp, -16
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)
    sw $s0, 12($sp)

    # Corps de la fonction
    li $s0, 0
    li $t4, 4
    li $t1, 7
    li $t0, 0
    loopToDecimal : beq		$t0, $a1, finConversionToDecimal	# if $t0 == $t1 then finConversionToDecimal
        mul $t2, $t0, $t4           # i*4
        add $t2, $a0, $t2           # t + i*4

        lw $t3, 0($t2)              # $t3 = t[i]
        sllv	$t5, $t3, $t1	    # $v0 = $t3 << $t1  0*2^7
        add $s0, $s0, $t5           

        addi $t0, $t0, 1            # On incremente i      
        addi $t1, $t1, -1           # On decremente j

        j loopToDecimal


    # epilogue
    finConversionToDecimal:
        move $v0, $s0
        lw $ra, 0($sp)
        lw $a0, 4($sp)
        lw $a1, 8($sp)
        lw $s0, 12($sp)
        addi $sp, $sp, 16

        jr $ra

################# Fonction cell_lecture_bit
# Entrées :
#   $a0 : le bit i
#   $a1 :  l'entier n 
# Pré-conditions :
#    $a0 entre [0, 7]
#    $a1 entre [0, 127] 
# Sorties : 
#     $v1 : le bit i de l'entier n
#
cell_lecture_bit:
    #prologue
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)


    # corps de la fonction
    # On converti l'entier n. e.g n = 5 $v0 -> [0, 0, 0, 0, 0, 1, 0, 1]


    jal convertToBinary
    #Calcul de l'addresse du bit i
    li $t7, 7
    sub $a0, $t7, $a0   # $a0 = 7 - i
    mul $t1, $a0, 4     # $t1 = (7 - i)*4
    add $t1, $v0, $t1   # $t1 = $v0 + (7 - i)*4

    lw $v1, 0($t1)      # le bit i -> $v1

    #epilogue
    lw $ra, 0($sp)
    lw $a0, 4($sp)
    sw $a1, 8($sp)
    addi $sp, $sp, 12 

    jr $ra
############################################################################

##################### Fonction cell_mettre_bit_a1
# Entrées :
#      $a0 : bit i
#      $a1 : Entier n
# Pré-conditions :
#      $a1 entre [0, 127]
# Sorties :
#      $v0 : Entier identique mais le bit i mis à 1
cell_mettre_bit_a1:
    # Prologue
    addi $sp, $sp, -16
    sw $ra,0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)
    sw $s0, 12($sp)
    
    # Corps de la fonction
    
    jal convertToBinary
    move $s0, $v0           # Addresse du tableau des bits -> $s0
    
    # Calcul de l'addresse du bit i
    li $t0, 1 
    li $t1, 7
    li $t2, 4
    sub $t1, $t1, $a0       # 7 - i
    mul $t1, $t1, $t2       # (7-i)*4
    add $t1, $s0, $t1       # $t1 = t + (7-i)*4

    sw $t0, 0($t1)          # tab[i] = 0

    move $a0, $s0
    li $a1, 8
    jal convertToDecimal


    # Epilogue
    lw $ra,0($sp)
    lw $a0, 4($sp)
    sw $a1, 8($sp)
    sw $s0, 12($sp)
    addi $sp, $sp, 16


    jr $ra

##########################################################################

##################### Fonction cell_mettre_bit_a0
# Entrées :
#      $a0 : bit i
#      $a1 : Entier n
# Pré-conditions :
#      $a1 entre [0, 127]
# Sorties :
#      $v0 : Entier identique mais le bit i mis à 0
cell_mettre_bit_a0:
    # Prologue
    addi $sp, $sp, -16
    sw $ra,0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)
    sw $s0, 12($sp)



    # Corps de la fonction
    
    jal convertToBinary
    move $s0, $v0           # Addresse du tableau des bits -> $s0
    
    # Calcul de l'addresse du bit i
    li $t0, 0 
    li $t1, 7
    li $t2, 4
    sub $t1, $t1, $a0       # 7 - i
    mul $t1, $t1, $t2       # (7-i)*4
    add $t1, $s0, $t1       # $t1 = t + (7-i)*4

    sw $t0, 0($t1)          # tab[i] = 0

    move $a0, $s0
    li $a1, 8
    jal convertToDecimal


    # Epilogue
    lw $ra,0($sp)
    lw $a0, 4($sp)
    sw $a1, 8($sp)
    sw $s0, 12($sp)
    addi $sp, $sp, 16


    jr $ra
#########################################################################


# LA PILE

############### Fonction st_creer
# Entrées : 
#   $a0 : Le nombre maximal d'entiers que la pile pourra contennir
# Pré-conditions :
#   $a0 > 0
# Sorties : 
#   $v0 : L'addresse de la pile

st_creer:
    # Note : 
    #   J'utilise les deux premières cases pour la taille maximale de la pile
    #   Et la hauteur qui est initialisé à zero
    # Prologue
    add $sp, $sp, -12
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $s0, 8($sp)

    # Corps de la fonction
    move $s0, $a0                   # Nombre d'élément du tableau -> $s0
    li $t0, 0                       # La hauteur (pile vide)

    li $t4, 4
    mul $a0, $a0, $t4               # taille en octet -> $a0
    addi $a0, $a0, 8                # La hauteur et la taille max -> 8 octets
    li $v0, 9
    syscall

    # Ecriture du nombre maximal d'entiers dans t[0]
    sw $s0, 0($v0)
    
    # Ecriture de 0 dans t[1]
    sw $t0, 4($v0)

    # Epilogue
    lw $ra, 0($sp)
    lw $a0, 4($sp)
    lw $s0, 8($sp)
    add $sp, $sp, 12 

    jr $ra
##########################################################################


################################# Fonction st_est_vide
# Entrées :
#   $a0 : Adresse de la pile
# Sorties :
#   $v0 : 1 si pile vide | 0 sinon
st_est_vide:
    #Prologue
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $a0, 4($sp)




    # Corps de la fonction
    lw $t0, 4($a0)                  # la hauteur -> $t0

    beqz $t0, pileVideTrue          # si $t0 = 0 la pile est vide
        li $v0, 0
        j finEstVide

    pileVideTrue:
        li $v0, 1

    finEstVide:
    # Epilogue
    lw $ra, 0($sp)
    lw $a0, 4($sp)
    addi $sp, $sp, 8

    jr $ra

############################################################################

################################ Fonction st_est_pleine
# Entrées: 
#    $a0 : l'addresse de la pile
# Sorties :
#    $v0 : 1 si la pile est pleine | 0 sinon
st_est_pleine:
    # Prologue
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $a0, 4($sp)


    # Corps de la fonction
    lw $t0, 0($a0)
    lw $t1, 4($a0)

    beq		$t0, $t1, pilePleine	# if $t0 == $t1 then pilePleine
        li $v0, 0
        j finPilePleine

    pilePleine:
        li $v0, 1

    # Epilogue
    finPilePleine:
        lw $ra, 0($sp)
        lw $a0, 4($sp)
        addi $sp, $sp, 8

        jr $ra
#############################################################################

################################# Fonction st_sommet
# Entrées : 
#       $a0 : addresse de la pile
# Pré-conditions :
#       La pile n'est pas vide
# Sortie :
#       $v0 : Le sommet
st_sommet:
    # Prologue
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $a0, 4($sp)

    # Corps de la fonction
    li $t4, 4
    lw $t0, 4($a0)              # la hauteur -> $t0
    addi $t0, $t0, 1
    mul $t0, $t0, $t4
    add $t0, $a0, $t0

    lw $v0, 0($t0)


    # Epilogue
    lw $ra, 0($sp)
    lw $a0, 4($sp)
    addi $sp, $sp, 8

    jr $ra
#############################################################################


################################ Fonction st_empiler
# Entrées : 
#   $a0 : l'addresse du tableau
#   $a1 : l'entier à ajouter
# Pré-conditions :
#   La pile n'est pas pleine
# Sortie:
#   On modifie le tableau à l'addresse $a0
st_empiler:
    # Prologue
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)


    # Corps de la fonction
    li $t4, 4
    lw $t0, 4($a0)          # la hauteur de la pile -> $t0

    addi $t1, $t0, 2        #  h + 2
    mul $t1, $t1, $t4       #  4*(h + 2)
    add $t1, $a0, $t1       #  t + 4*( h + 2)

    sw $a1, 0($t1)          # On empile $a1

    addi $t0, $t0, 1        # Incrementation de la hauteur
    sw $t0, 4($a0)          # Mise à jour de la hauteur


    # Epilogue
    lw $ra, 0($sp)
    lw $a0, 4($sp)
    lw $a1, 8($sp)
    addi $sp, $sp, 12

    jr $ra

################################# Fonction st_depiler
# Entrées :
#   $a0 : Addresse du tableau
# Pré-condition:
#   La pile n'est pas vide
# Sortie :
#   On modifie juste le tableau à l'addresse $a0
st_depiler:
    # Prologue
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $a0, 4($sp)


    # Corps de la fonction
    li $t1, 0
    li $t4, 4
    lw $t0, 4($a0)              # la hauteur -> $t0
    addi $t0, $t0, 1
    mul $t0, $t0, $t4
    add $t0, $a0, $t0

    sw $t1, 0($t0)              # On remplace le sommet par 0

    lw $t0, 4($a0)              # la hauteur -> $t0
    addi $t0, $t0, -1           # On decremente la hauteur
    sw $t0, 4($a0)              # Mis à jour de la hauteur

    # Epilogue
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    addi $sp, $sp, 8

    jr $ra
##########################################################################

# 3.3 Le labyrinthe

################################# Fonction creerLabyrinthe
# Entrées :
#   $a0 : taille N du labyrinthe (Matrice carré)
# Pré-condition : 
#   $a0 > 0
# Sorties :
#   $v0 : Addresse du labyrinthe
creerLabyrinthe:
    # Prologue
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $a0, 4($sp)


    # Corps de la fonction
    # Allocation de N*N*4 dans le tas
    li $t4, 4
    mul $t1, $a0, $a0               # N*N
    mul $a0, $t1, $t4               # N*N*4

    li $v0, 9
    syscall

    li $t2, 15
    li $t0, 0                       # Itérateur

    loopCreerLabyInit15 : beq		$t0, $t1, finCreerLaby	# if $t0 = $t1 then finCreerLaby
        # Calcul addresse cell courante
        mul $t3, $t0, $t4           # 4 * i
        add $t3, $v0, $t3           # t + 4*i

        sw $t2, 0($t3)                 # t[i] = 15

        addi $t0, $t0, 1
        j loopCreerLabyInit15
    
    # Epilogue
    finCreerLaby:
        lw $ra, 0($sp)
        lw $a0, 4($sp)
        addi $sp, $sp, 8

        jr $ra

############################################################################

################################ Fonction afficheLaby
# Entrées : 
#     $a0 : taille du laby
#     $a1 : addresse du laby
# Sorties :
#     afficher le tableau
afficheLaby:
    # Prologue
    addi $sp, $sp, -20
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)
    sw $s0, 12($sp)
    sw $s1, 16($sp)


    # Corps de la fonction
    # Affichage de la taille en première ligne
    jal AfficheEntier

    move $s1, $a0               # la taille N -> $s1
    mul $t1, $a0, $a0
    li $t4, 4
    li $t0, 0                   # itérateur
    loopAfficheLaby: beq		$t0, $t1, finAfficheLaby	# if $t0 == $t1 then finAfficheLaby
        # Calcul addresse cell courante
        mul $t2, $t0, $t4       # 4*i 
        add $t2, $a1, $t2       # t + 4*i

        lw $t3, 0($t2)          # val = t[i]

        # si i % N == 0, on affiche la valeur et on part à la ligne
        # sinon affiche la valeur et un espace
        move $s0, $t0           # j = i
        addi $s0, $s0, 1        # j = i + 1
        div $s0, $s1            # j / N
        mfhi $t5

        beqz $t5 afficheValeurEtRetChar
        # sinon 
        
        # On ecrit la valeur
        move $a0, $t3
        li $v0, 1
        syscall

        # On ecrit l'espace
        la $a0, espace
        li $v0, 4
        syscall

        j finIfElse


        afficheValeurEtRetChar:
            move $a0, $t3
            li $v0, 1
            syscall

            la $a0, RetChar
            li $v0, 4
            syscall
        
        finIfElse:
            addi $t0, $t0, 1
            j loopAfficheLaby


    # Epilogue
    finAfficheLaby:
        lw $ra, 0($sp)
        lw $a0, 4($sp)
        lw $a1, 8($sp)
        lw $s0, 12($sp)
        lw $s1, 16($sp)
        addi $sp, $sp, 20

        jr $ra


############################################################################
################################ Fonction getValueCellIndiceI
#  Entrées :
#       $a0 : indice de la cellule
#       $a1 : addresse du labyrinthe
#  Pré-conditions:
#       $a0 app [0, N*N]
#  Sorties :
#       $v0 : valeur de la cellule à l'indice i
getValueCellIndiceI:
    # Prologue
    addi $sp, $sp, -16
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)
    sw $s0, 12($sp)


    # Corps de la fonction
    li $s0, 4
    mul $s0, $s0, $a0
    add $s0, $s0, $a1

    lw $v0, 0($s0)

    # Epilogue
    lw $ra, 0($sp)
    lw $a0, 4($sp)
    lw $a1, 8($sp)
    lw $s0, 12($sp)
    addi $sp, $sp, 16
    jr $ra

###########################################################################
############################################################################
################################ Fonction setValueCellIndiceI
#  Entrées :
#       $a0 : indice de la cellule
#       $a1 : addresse du labyrinthe
#       $a2 : la Nouvelle valeur
#  Pré-conditions:
#       $a0 app [0, N*N]
#  Sorties :
#       On modifie le labyrinthe
setValueCellIndiceI:
    # Prologue
    addi $sp, $sp, -20
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)
    sw $a2, 12($sp)
    sw $s0, 16($sp)


    # Corps de la fonction
    li $s0, 4
    mul $s0, $s0, $a0
    add $s0, $s0, $a1

    sw $a2, 0($s0)

    # Epilogue
    lw $ra, 0($sp)
    lw $a0, 4($sp)
    lw $a1, 8($sp)
    lw $a2, 12($sp)
    lw $s0, 16($sp)
    addi $sp, $sp, 20 

    jr $ra
##########################################################################

################################# Fonction getIndiceVoisinSelonDirection
# Entrées :
#   $a0 : indice cellule courante
#   $a1 : Adresse du laby
#   $a2 : Direction (haut, droite, bas, gauche)
#   $a3 : La taille N du laby
# Pré-conditions:
#   $a0 app [0, N*N]
# Sorties :
#   $v0 : indice de la celulle se trouvant à la direction $a2
#         | ou indice cellule courante (si jamais y en a pas).
#         e.g : cell inidice i = 0 pas de voisin en haut, donc $v0 = 0
getIndiceVoisinSelonDirection:
    # Prologue
    addi $sp, $sp, -40
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)
    sw $a2, 12($sp)
    sw $a3, 16($sp)
    sw $s0, 20($sp)
    sw $s1, 24($sp)
    sw $s2, 28($sp)
    sw $s3, 32($sp)
    sw $s4, 36($sp)



    # Corps de la fonction
    move $s0, $a0                   # indice i -> $s0
    move $s1, $a3                   # taille N -> $s1
    div $s0, $s1
    mfhi $s2                        # i % N -> $s2
    
    # Valeurs pour les tests
    subi	$s3, $s1, 1			    # $s3 = $s1 - 1 | N-1
    mul $s4, $s1, $s3               # $s4 = N*(N-1)

    beq $a2, 0 voisinHaut
    beq $a2, 1 voisinDroite
    beq $a2, 2 voisinBas
    beq $a2, 3 voisinGauche

    voisinHaut:
        blt		$s0, $s1, finVoisin	# if $s0 < $s1 then finVoisin (Pas de voisin en haut)
        sub $v0, $s0, $s1           # sinon l'indice vaut i - N
        j finGetIndiceVoisin
        
    voisinDroite:
        beq		$s2, $s3, finVoisin	# if $s2 == $s3 then finVosin (Pas de voisin à droite)
        addi $v0, $s0, 1            # else l'indice vaut i + 1
        j finGetIndiceVoisin

    voisinBas:
        beq		$s0, $s4, finVoisin	# if $s0 == $s4 then finVosin (Pas de vosin en bas)
        add $v0, $s0, $s1           # else l'indice vaut i + N
        j finGetIndiceVoisin

    voisinGauche:
        beq		$s2, 0, finVoisin    # if $s2 (i%N) == 0 then finVoisin (Pas de voisin a gauche) 
        subi $v0, $s0, 1            # else l'indice vaut i - 1
        j finGetIndiceVoisin
        
    finVoisin:
        move $v0, $a0

    # Epilogue
    finGetIndiceVoisin:
        lw $ra, 0($sp)
        lw $a0, 4($sp)
        lw $a1, 8($sp)
        lw $a2, 12($sp)
        lw $a3, 16($sp)
        lw $s0, 20($sp)
        lw $s1, 24($sp)
        lw $s2, 28($sp)
        lw $s3, 32($sp)
        lw $s4, 36($sp)
        addi $sp, $sp, 40 
    
        jr $ra

#################################Fonction AfficheTableau
###entrées: 
###   $a0: taille (en nombre d'entiers) du tableau à afficher
###   $a1: l'addresse du tableau à afficher
###Pré-conditions: $a0 >=0
###Sorties:
###Post-conditions: les registres temp. $si sont rétablies si utilisées
AfficheTableau:
    #prologue:
    subu $sp $sp 24
    sw $s0 20($sp)
    sw $s1 16($sp)
    sw $s2 12($sp)
    sw $a0 8($sp)
    sw $a1 4($sp)
    sw $ra 0($sp)

    #corps de la fonction:
    la $a0 Tableau
    li $v0 4
    syscall
    lw $a0 8($sp)
    jal AfficheEntier
    la $a0 Aladresse
    li $v0 4
    syscall
    lw $a0 4($sp)
    jal AfficheEntier

    lw $a0 8($sp)
    lw $a1 4($sp)

    li $s0 4
    mul $s2 $a0 $s0 #$a0: nombre d'octets occupés par le tableau
    li $s1 0 #s1: variable incrémentée: offset
    LoopAffichage:
        bge $s1 $s2 FinLoopAffichage
        lw $a1 4($sp)
        add $t0 $a1 $s1 #adresse de l'entier: adresse de début du tableau + offset
        lw $a0 0($t0)
        jal AfficheEntier
        addi $s1 $s1 4 #on incrémente la variable
        j LoopAffichage

    FinLoopAffichage:
        la $a0 RetChar
        li $v0 4
        syscall

        #épilogue:
        lw $s0 20($sp)
        lw $s1 16($sp)
        lw $s2 12($sp)
        lw $a0 8($sp)
        lw $a1 4($sp)
        lw $ra 0($sp)
        addu $sp $sp 24
        jr $ra
###########################################################################

#################################Fonction AfficheEntier
###entrées: $a0: entier à afficher
###Pré-conditions:
###Sorties:
###Post-conditions:
AfficheEntier:
    #prologue:
    subu $sp $sp 8
    sw $a0 4($sp)
    sw $ra 0($sp)

    #corps de la fonction:
    li $v0 1
    syscall

    la $a0 RetChar
    li $v0 4
    syscall

    #épilogue:
    lw $a0 4($sp)
    lw $ra 0($sp)
    addu $sp $sp 8
    jr $ra
#########################################################

Exit: # fin du programme
    li $v0 10
    syscall