
===========
VHDLToolbox
===========

VHDLToolbox is a collection of very simple VHDL components from which systems can be made.


add.vhd:  adder
===============

Produces a stream of data *out1* by adding *in1* to *in2* item by item.

and.vhd:  bitwise_and
=====================

Produces a stream of data *out1* by adding *in1* to *in2* item by item.

assert.vhd: asserter (simulation only)
======================================

Raise an exception if *in1* is 0.

constant.vhd: constant_value
============================

Output constant value repeatedly.

counter.vhd: counter
====================

A counter component

+ The first data item in the sequence is defined by the *start* parameter.
+ Subsequent data item in the sequence are ncremented by the *step* parameter.
+ The counter may reach, but not exceed the *stop* parameter.
+ Any count in excess of *stop* will return the counter to the *start* value.

cout.vhd: console_output
========================

Write a stream of data to the console.

discard.vhd: discard
====================

Discard all data on *in1*. Useful to avoid unconnected outputs.

div.vhd: divider
================

Produces a stream of data *out1* by dividing *in1* by *in2* item by item.

eq.vhd: comparator_equal
========================

Produces a stream of data *out1* which is 1 if *in1* equals *in2* or 0 otherwise.

fifo.vhd: FIFO
==============

Store up to *depth* data items.

ge.vhd: comparator_greater_than_or_equal
========================================

Produces a stream of data *out1* which is 1 if *in1* is greater_than_or_equal to *in2* or 0 otherwise.

gigabit_ethernet.vhd: gigabit_ethernet
======================================

Send and receive Ethernet packets. Using a Ethernet Physical Interface.

Features:

+ Supports 1Gbit/s ethernet only via a gmii interface.
+ Supports full duplex mode only.

Interface

:input: TX - Data to send (16 bits).
:output: RX - Data to send (16 bits).

Ethernet Packet Structure
-

+-------------+-------------+--------+--------+---------+---------+-----+
| Description | destination | source | length | payload | padding | FSC |
+=============+=============+========+========+=========+=========+=====+
|    Bytes    |      6      |   6    |    2   |  0-1500 |   0-46  |  4  |
+-------------+-------------+--------+--------+---------+---------+-----+

Notes:

    + The *length* field is the length of the ethernet payload.
    + The *Ethernet Output* block will automatically append the FSC to 
      outgoing packets.
    + The *FSC* of incoming packets will be checked, and bad packets will
      be discarded. The *FSC* will be stripped from incoming packets.
    + The length of the *payload* + *padding* must be 46-1500 bytes.
    + Incoming packets of incorrect *length* will be discarded.

Usage
-----

Transmit
~~~~~~~~
The first 16 bit word on the TX input is interpreted as the length of the
packet in bytes (including the MAC address, length and payload, but not the 
preamble or FSC). Subsequent words on the TX input are interpreted as the
content of the packet. If length is an odd number of bytes, then the least
significant byte of the last word will be ignored.
The FSC will be appended for you, but you need to supply the destination,
source and length fields.

Receive
~~~~~~~~
The first 16 bit word on the RX output will be the length of the packet in 
bytes (including the MAC address, length and payload, but not the 
preamble or FSC). Subsequent words on the RX output will be the
content of the packet. If length is an odd number of bytes, then the least
significant byte of the last word will not contain usefull data.
The FSC will be stripped from incoming packets, but the destination,
source and length fields will be included.

Hardware details
----------------
This component used two clocks, the local clock used to transfer data
between components, and a 125MHz clock source for sending data to the
Ethernet physical interface. This clock is also forwarded along with the
data to the ethernet phy.


gt.vhd: comparator_greater_than
===============================

Produces a stream of data *out1* which is 1 if *in1* is greater_than to *in2* or 0 otherwise.

input_file.vhd: file_input (simulation only)
============================================

Read a stream of data from a text file in ASCII decimal representation.

:output: out1 - The output data stream
:parameter: bits - The *width* in bits of the output data stream
:parameter: filename - The *file name*  of the input file.

input_pin_port.vhd: device_pin_input
====================================

Device input pin.

left_shift.vhd: left_shift
==========================

Produces a stream of data *out1* by left shifting *in1* by *in2* places item by item.

:input: in1 - input stream of numbers to be shifted
:input: in2 - input stream of amount to shift by
:output: out1 - output stream containing shifted data
:paremeter: bits - the width of in1, in2 and out1 straddereams in *bits*

Both *in1* and *in2* are treated as signed numbers, if in2 is negative, in1 will be shifted right.
If a right shift occurs, the value will be sign extended.

le.vhd: comparator_less_than_or_equal
=====================================

Produces a stream of data *out1* which is 1 if *in1* is less_than_or_equal to *in2* or 0 otherwise.

lt.vhd: comparator_less_than
============================

Produces a stream of data *out1* which is 1 if *in1* is less_than to *in2* or 0 otherwise.

mod.vhd: modulo
===============

Produces a stream of data *out1* by dividing *in1* by *in2* item by item.

mul.vhd: multiplier
===================

Produces a stream of data *out1* by multiplying *in1* by *in2* item by item.

ne.vhd: comparator_not_equal
============================

Produces a stream of data *out1* by which is 1 if *in1* is equal to *in2* or 0 otherwise.

or.vhd: bitwise_or
==================

Produces a stream of data *out1* which is the bitwise OR of *in1* and *in2*.

output_file.vhd: file_output (simulation only)
==============================================

Write a stream of data to a text file as an ASCII decimal representation.

:input: in1 - The input data stream
:parameter: bits - The *width* in bits of the input data stream
:parameter: filename - The *file name*  of the output file.

output_pin_port.vhd: device pin output
======================================

Send a stream of data to a device pin(s).

resize.vhd: resizer
===================

Produces a stream of data *out1* by resizing *in1* item by item.

Interface

:input: in1 - input stream of numbers to be resized
:output: out1 - output stream containing resized data
:parameter: input_bits - the width of in1 in *bits*
:parameter: output_bits - the width of out1 in *bits*

Usage
-----
Both *in1* is treated as a signed number. If *output_bits* is greater than
*input_bits* then *in1* will be sign extended. If *input_bits* is greater 
than *output_bits* then *in1* will be truncated.


right_shift.vhd: right_shift
============================

Produces a stream of data *out1* by right shifting *in1* by *in2* places item by item.

:input: in1 - input stream of numbers to be shifted
:input: in2 - input stream of amount to shift by
:output: out1 - output stream containing shifted data
:paremeter: bits - the width of in1, in2 and out1 straddereams in *bits*

Both *in1* and *in2* are treated as signed numbers, if in2 is negative, in1 will be shifted left.
If a right shift occurs, the value will be sign extended.


serial_in.vhd: serial_input
===========================

Serial Input
============

Read a stream of data from a serial UART using 8N1 convention.

Generics
--------

 + baud_rate
 + clock frequency

serial_out.vhd: serial_output
=============================

Write a stream of data to a serial UART using 8N1 convention

Generics
--------

 + baud_rate
 + clock frequency

sub.vhd: subtractor
===================

Produces a stream of data *out1* by subtracting *in2* from *in1* item by item.

tee.vhd: tee
============

Create two streams from one.

xor.vhd: bitwise_xor
====================

Produces a stream of data *out1* which is the bitwise XOR of *in1* and *in2*.
