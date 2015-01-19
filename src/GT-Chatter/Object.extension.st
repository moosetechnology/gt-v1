Extension { #name : #Object }

{ #category : #'*GT-Chatter' }
Object >> asSentMessage [
	^ GTSentMessage new
			message: self;
			timestamp: DateAndTime now;
			yourself
]
