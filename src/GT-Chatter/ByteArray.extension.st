Extension { #name : #ByteArray }

{ #category : #'*GT-Chatter' }
ByteArray >> unzipped [
	| magic1 magic2 |
	magic1 := (self at: 1) asInteger.
	magic2 := (self at: 2) asInteger.
	(magic1 = 16r1F and:[magic2 = 16r8B]) ifFalse:[^self].
	^(GZipReadStream on: self) upToEnd
]

{ #category : #'*GT-Chatter' }
ByteArray >> zipped [
	| stream gzstream |

	stream := RWBinaryOrTextStream on: self class new.

	gzstream := GZipWriteStream on: stream.
	gzstream nextPutAll: self.
	gzstream close.
	stream reset.

	^ stream contents.

]
