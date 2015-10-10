Class {
	#name : #GTStonPacking,
	#superclass : #GTEventPacking,
	#category : #'GT-EventRecorder-Core'
}

{ #category : #private }
GTStonPacking >> materialize: aByteArray [
	| stream gzstream |
	stream := aByteArray readStream. 
	gzstream := GZipReadStream on: stream.
	^ [ STON fromStream: gzstream ] ensure: [ gzstream close. stream close ]
]

{ #category : #private }
GTStonPacking >> serialize: anObject [
	^ String streamContents: [ :stream | | gzstream |
		gzstream := GZipWriteStream on: stream.
		[ STON put: anObject onStreamPretty: gzstream ]
			ensure: [ gzstream close ] ]
]
