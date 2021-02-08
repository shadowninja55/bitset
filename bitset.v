module bitset

import bitfield

pub struct BitSet {
pub:
	size int
mut:
	bf bitfield.BitField
}

[inline]
pub fn new(size int) BitSet {
	return BitSet {
		size: size
		bf: bitfield.new(size)
	}
}

[inline]
pub fn (bs BitSet) contains(bit int) bool {
	return bs.bf.get_bit(bit) == 1
}

[inline]
pub fn (mut bs BitSet) add(bit int) {
	bs.bf.set_bit(bit)
}

[inline]
pub fn (mut bs BitSet) remove(bit int) {
	bs.bf.clear_bit(bit)
}

pub fn (bs BitSet) str() string {
	mut res := "{"
	mut first := true

	for bit in 0..bs.size {
		if bs.contains(bit) {
			if _unlikely_(first) {
				res += bit.str()
				first = false
			} else {
				res += ", $bit"
			}
		}
	}

	return res + "}"
}

[inline]
pub fn (a BitSet) == (b BitSet) bool {
	return a.bf == b.bf
}

/*
struct BitSetIterator {
	bs BitSet
	size int
mut:
	curr int
}

[inline]
pub fn (bs BitSet) items() BitSetIterator {
	return BitSetIterator {
		bs: bs
		size: bs.size
		curr: 0
	}
}

fn (mut bsi BitSetIterator) next() ?int {
	for {
		if bsi.curr >= bsi.size {
			return none
		}

		if bsi.bs.contains(bsi.curr) {
			item := bsi.curr
			bsi.curr++
			return item
		}

		bsi.curr++
	}

	return 1337
}
*/