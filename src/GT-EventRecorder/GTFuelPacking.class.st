"
I serialize or materialize objects using FUEL framework. Create instance of me calling GTEventPacking fuel.
"
Class {
	#name : #GTFuelPacking,
	#superclass : #GTEventPacking,
	#category : #'GT-EventRecorder-Core'
}

{ #category : #private }
GTFuelPacking >> materialize: aByteArray [
	| materializer stream gzstream materialization |
	stream := aByteArray readStream. 
	gzstream := GZipReadStream on: stream.
	materializer := FLMaterializer newDefault.
	materialization := materializer materializeFrom: gzstream.
	gzstream close.
	stream close.
	^ materialization root.
]

{ #category : #private }
GTFuelPacking >> serialize: anObject [
	| serializer stream gzstream |
	stream := ByteArray new writeStream binary. 
	gzstream := GZipWriteStream on: stream.
	serializer := FLSerializer newDefault.
	serializer at: #recorderVersion putAdditionalObject: self version.
	serializer stream: gzstream.
	serializer serialize: anObject.
	gzstream close.
	stream close.
	^ stream contents.
]
