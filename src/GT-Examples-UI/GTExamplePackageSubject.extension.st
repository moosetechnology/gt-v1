Extension { #name : #GTExamplePackageSubject }

{ #category : #'*GT-Examples-UI' }
GTExamplePackageSubject >> addToSelectorEnvironment: aSelectorEnvironment [
	self thePackage ifNil: [ ^ self ].
	
	self thePackage classes do: [ :class | 
		aSelectorEnvironment addClass: class ].
	self thePackage extensionMethods do: [ :method | 
		aSelectorEnvironment addClass: method methodClass selector: method selector ]
]

{ #category : #'*GT-Examples-UI' }
GTExamplePackageSubject >> forNautilus: aBlock [
	self exists ifFalse: [ ^ self ].
	
	aBlock 
		value: #'Browse package-subject "' ,  self thePackageName , '"'
		value: [ self thePackage browse ]
]

{ #category : #'*GT-Examples-UI' }
GTExamplePackageSubject >> gtDisplayOn: aStream [
	self thePackageName gtDisplayOn: aStream.
	self gtDisplayValidityOn: aStream
]
