Extension { #name : #Collection }

{ #category : #'*GT-SUnitDebugger' }
Collection >> gtSUnitPrint [

	^ String streamContents: [:s | self asStringOn: s delimiter: Character cr asString]
]
