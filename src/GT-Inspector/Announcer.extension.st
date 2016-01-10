Extension { #name : #Announcer }

{ #category : #'*GT-Inspector-Examples-Core' }
Announcer >> unsubscribeThoroughly: aClass [
	^ registry protected: [
		registry subscriptions removeAllSuchThat: [ :subscription | 
			subscription subscriber class == aClass ] ]

]
