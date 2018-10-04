Extension { #name : #GTExampleHelpSubject }

{ #category : #'*GT-Examples-UI' }
GTExampleHelpSubject >> forNautilus: aBlock [
	aBlock 
		value: #'Browse help-subject "' ,  self topic gtDisplayString , (self title ifNotNil: [ ' > ', self title ] ifNil: [ '' ]) , '"'
		value: [ 
			| browser |
			browser := (HelpBrowser openOn: self topic).
			self title ifNotNil: [ browser selectTopicSatisfying: [ :subhelp | subhelp title = self title ] ] ]
]

{ #category : #'*GT-Examples-UI' }
GTExampleHelpSubject >> gtDisplayOn: aStream [
	self exists 
		ifTrue: [ self topic gtDisplayOn: aStream ]
		ifFalse: [ 
			self bookName gtDisplayOn: aStream.
			self title isEmptyOrNil ifFalse: [ 
				aStream nextPutAll: ' > '.
				self title gtDisplayOn: aStream ] ].
	self gtDisplayValidityOn: aStream
]
