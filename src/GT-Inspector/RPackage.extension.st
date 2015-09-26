Extension { #name : #RPackage }

{ #category : #'*GT-Inspector-Examples-UI' }
RPackage >> gtExamplesContained [
	^ self classes gather: [ :each | each gtExamples ]
]

{ #category : #'*GT-Inspector-Examples-Tools' }
RPackage >> matchesPackagePattern: aStringOrPattern [
	^ self packageName = aStringOrPattern
		or: [ (aStringOrPattern match: self packageName) 
			or: [ [ self packageName matchesRegexIgnoringCase: aStringOrPattern ] 
						on: Error 
						do: [ false ] ] ]
]
