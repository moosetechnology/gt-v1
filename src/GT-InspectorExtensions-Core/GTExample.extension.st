Extension { #name : #GTExample }

{ #category : #'*GT-InspectorExtensions-Core' }
GTExample classSide >> gtExampleBasic [
	<todo: 'fix: corrupt image state if this is an example itself'>
	"<gtExample>"
	^ self new
		initializeFromFinder: (GTExampleFinder new
										source: self;
										provider: self;
										subjects: nil;
										yourself) 
			withPragma: ((GTExample class >> #gtExampleBasic) pragmas 
										detect: [ :each | each isGTExamplePragma ]);
		yourself
]
