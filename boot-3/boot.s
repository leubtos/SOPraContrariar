##
#This is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#This is a part of SoPraContrariar OS bootloader
#boot: bootloader whos only runs NOP operation
#
#Powered by: Felipe Kazuyoshi; Jefferson Ihida; Leonardo Zanguetin; Leonardo Urbani
#SoPraContrariar Copyright©
##

.section	.text
.globl		_start

_start:
.code16

		xorw	%ax, %ax
		movw	%ax, %ds
		movw	%ax, %ss
		movw	%ax, %fs
		
		jmp start

.type		getchar, @function


getchar:
		mov 	$0x00, %ah
		int 	$0x16 
		movb	$0x0E, %ah #we've tried 0x0a, didnt work
		int	$0x10
		ret


.type		erase_screen, @function

erase_screen:
		
		movb    $0x02, %al
        movb    $0x0,  %ah
        int     $0x10
        jmp start
        

start:
		call 	getchar

		cmp	$'1', %al
		je 	erase_screen

		jmp 	start


. = _start + 510
.byte		0X55, 0xAA


