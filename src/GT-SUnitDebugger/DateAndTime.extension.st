Extension { #name : #DateAndTime }

{ #category : #'*GT-SUnitDebugger' }
DateAndTime >> gtSUnitPrint [

	^ String streamContents: [:s | self printSeparateDateAndTimeOn: s]
]
