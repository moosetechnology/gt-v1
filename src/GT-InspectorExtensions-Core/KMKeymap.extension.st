Extension { #name : #KMKeymap }

{ #category : #'*GT-InspectorExtensions-Core' }
KMKeymap >> gtDisplayOn: aStream [
	aStream 
		nextPutAll: self name gtDisplayString;
		nextPutAll: ' on ';
		nextPutAll: self shortcut gtDisplayString;
		nextPutAll: ' do ' ;
		nextPutAll: self action gtDisplayString
]
