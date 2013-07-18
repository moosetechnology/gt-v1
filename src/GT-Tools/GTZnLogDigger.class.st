"
ZnServer startDefaultOn: 8080. 
ZnServer default logToTranscript.
ZnServer default debugMode: true; inspect.
memoryLogger := ZnMemoryLogger new.
ZnServer default log addListener: memoryLogger.
ZnClient new get: 'http://localhost:8080/random'.
""ZnServer default delegate map: #image to: MyFirstWebApp new.""

specificEvents := memoryLogger logEvents collect: [ :each | 
	| result |
	result := (GTZnLogDigger new getParser parse: each message).
	result isPetitFailure ifTrue: [ each ] ifFalse: [ result message: each message ] ].

GTZnLogDigger openOn: specificEvents.
"
Class {
	#name : #GTZnLogDigger,
	#superclass : #GLMCompositePresentation,
	#category : #'GT-Tools-Prototypes'
}

{ #category : #'as yet unclassified' }
GTZnLogDigger >> compose [
	self list
		
]

{ #category : #'as yet unclassified' }
GTZnLogDigger >> getParser [
	| number code url size duration get |
	number := #digit asParser star flatten ==> #asNumber.
	code := number.
	url := #space asParser negate star flatten.
	size := number , 'B' asParser ==> #first.
	duration := number , 'ms' asParser ==> #first.
	get := 'GET' asParser trim , url , code trim, size trim, duration.
	^ get ==> [ :t | GTZnGetLogEvent new url: t second; code: t third; dimension: t fourth; duration: t fifth ]
]
