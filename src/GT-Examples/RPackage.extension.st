Extension { #name : #RPackage }

{ #category : #'*GT-Examples-UI' }
RPackage >> gtExamplesContained [
	| examples |
	examples := OrderedCollection new.
	self methods do: [ :method |
		method gtExamplesFactory exampleMethod: method do: [ :example | 
			examples add: example ] ].
	^ examples
]

{ #category : #'*GT-Examples-Tools' }
RPackage >> matchesPackagePattern: aStringOrPattern [
	^ self packageName = aStringOrPattern
		or: [ (aStringOrPattern match: self packageName) 
			or: [ [ self packageName matchesRegexIgnoringCase: aStringOrPattern ] 
						on: Error 
						do: [ false ] ] ]
]
