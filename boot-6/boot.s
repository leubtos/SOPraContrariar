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
		movb 	$0x00, %ah
		int 	$0x16 
		movb	$0x0A, %ah #Write Character at Cursor
		int	$0x10
		ret


.type		erase_screen, @function

erase_screen:
		
		movb    $0x02, %al
            	movb    $0x0,  %ah
            	int     $0x10
            	ret


text_string: .asciz  "BL versao 1.0"

.type		print_version, @function

print_version:
		
	mov  $0x0E, %ah		

.type		repeat, @function

repeat:
	lodsb			
	cmp  $'0',%al
	je start		
	int $0x10			
	jmp repeat


.type		boot_type, @function

boot_type:
	
		mov  $text_string,%si	
		jmp print_version

.type		boot_type, @function

nova_era:	

		int $0x19	#nova_era_brings_the_ashes_back_to_life
		ret

start:
		call 	getchar

		cmp	$'1', %al
		je 	erase_screen

		cmp	$'2', %al
		je 	boot_type
		
		#cmp	$'3', %al
		#je 	boot_type


		cmp	$'4', %al
		je 	nova_era

		

		jmp 	start




. = _start + 510
.byte		0X55, 0xAA



