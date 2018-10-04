Extension { #name : #MCWorkingCopy }

{ #category : #'*GT-Examples-Examples' }
MCWorkingCopy class >> gtExampleWorkingCopy [
	<gtExample>
	<label: 'Metacello working-copy'>
	
	^ (RPackageOrganizer default packageOf: GTExample) mcPackage 
		ifNotNil: [ :mcp | mcp workingCopy ]
]
