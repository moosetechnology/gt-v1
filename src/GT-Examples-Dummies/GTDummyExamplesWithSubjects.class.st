Class {
	#name : #GTDummyExamplesWithSubjects,
	#superclass : #GTAbstractDummyExamples,
	#category : #'GT-Examples-Dummies-Data'
}

{ #category : #examples }
GTDummyExamplesWithSubjects >> classSubject [
	<gtExample>
	<subjectClass: 'GTExample'>
	
	self assert: self gtExampleContext example subjects first class = GTExampleClassSubject.
	self assert: self gtExampleContext example subjects first theClassName = 'GTExample'.
	self assert: self gtExampleContext example subjects first theClass = GTExample.
	self assert: self gtExampleContext example subjects first exists.
	
	^ 0
]

{ #category : #examples }
GTDummyExamplesWithSubjects >> helpSubject [
	<gtExample>
	<subjectHelp: 'GT Inspector'>
	
	self assert: self gtExampleContext example subjects first class = GTExampleHelpSubject.
	self assert: self gtExampleContext example subjects first bookName = 'GT Inspector'.
	self assert: self gtExampleContext example subjects first title isNil.
	self assert: self gtExampleContext example subjects first topic notNil.
	
	^ 0
]

{ #category : #examples }
GTDummyExamplesWithSubjects >> helpSubjectWithTitle [
	<gtExample>
	<subjectHelp: 'GT Inspector' title: 'Roassal'>
	
	self assert: self gtExampleContext example subjects first class = GTExampleHelpSubject.
	self assert: self gtExampleContext example subjects first bookName = 'GT Inspector'.
	self assert: self gtExampleContext example subjects first title = 'Roassal'.
	self assert: self gtExampleContext example subjects first topic notNil.
	
	^ 0
	
]

{ #category : #examples }
GTDummyExamplesWithSubjects >> keywordsSubject [
	<gtExample>
	<subjectKeywords: #( 'Justo' 'Malesuada' 'Bibendum' 'Adipiscing' 'Elit' )>
	<subjectKeyword: 'Tristique'>
	
	self assert: self gtExampleContext example subjects first class = GTExampleKeywordSubject.
	self assert: self gtExampleContext example subjects size = 6.
	self assert: (self gtExampleContext example subjects collect: [ :each | each keyword ]) asSet = #( 'Justo' 'Malesuada' 'Bibendum' 'Adipiscing' 'Elit' 'Tristique' ) asSet.
	
	^ 0
]

{ #category : #examples }
GTDummyExamplesWithSubjects >> metaclassSubject [
	<gtExample>
	<subjectClass: 'GTExample class'>

	self assert: self gtExampleContext example subjects first class = GTExampleClassSubject.
	self assert: self gtExampleContext example subjects first theClassName = 'GTExample class'.
	self assert: self gtExampleContext example subjects first theClass = GTExample class.
	self assert: self gtExampleContext example subjects first exists.
	
	^ 0
]

{ #category : #examples }
GTDummyExamplesWithSubjects >> metaclassSubjectBySymbol [
	<gtExample>
	<subjectClass: #'GTExample class'>
	
	self assert: self gtExampleContext example subjects first class = GTExampleClassSubject.
	self assert: self gtExampleContext example subjects first theClassName = 'GTExample class'.
	self assert: self gtExampleContext example subjects first theClass = GTExample class.
	self assert: self gtExampleContext example subjects first exists.
	
	^ 0
]

{ #category : #examples }
GTDummyExamplesWithSubjects >> multipleSubjects [
	<gtExample>
	<subjectClass: 'GTExample' selector: #methodClass>
	<subjectClass: #GTExample selector: #selector>
	<subjectClass: 'GTExample class' selector: #selector> " does not exist "
	<subjectClass: #GTExample selector: #run>
	<subjectHelp: 'GT Inspector'>
	<subjectClass: 'GTExample'>
	<subjectText: 'Justo Malesuada Bibendum Adipiscing Elit'>
	<subjectText: 'Donec sed odio dui'>
	<subjectKeywords: #( 'Donec' 'sed' 'odio' 'dui' )>
	<subjectKeyword: 'Malesuada'>
	
	self assert: self gtExampleContext example subjects size = 13.
	self assert: (self gtExampleContext example subjects select: [ :each | each exists ]) size = 12.
	
	^ 0
]

{ #category : #examples }
GTDummyExamplesWithSubjects >> packageSubject [
	<gtExample>
	<subjectPackage: 'GT-Examples'>

	self assert: self gtExampleContext example subjects first class = GTExamplePackageSubject.
	self assert: self gtExampleContext example subjects first thePackageName = 'GT-Examples'.
	self assert: self gtExampleContext example subjects first thePackage notNil.
	self assert: self gtExampleContext example subjects first exists.
	
	^ 0
]

{ #category : #examples }
GTDummyExamplesWithSubjects >> tagSubject [
	<gtExample>
	<subjectTag: 'GT-Examples-Dummies-Data'>
	
	self assert: self gtExampleContext example subjects first class = GTExampleTagSubject.
	self assert: self gtExampleContext example subjects first theTagName = 'GT-Examples-Dummies-Data'.
	self assert: self gtExampleContext example subjects first theTag notNil.
	self assert: self gtExampleContext example subjects first thePackage notNil.
	self assert: self gtExampleContext example subjects first exists.
	
	^ 0
]

{ #category : #examples }
GTDummyExamplesWithSubjects >> tagSubjectShortened [
	<gtExample>
	<subjectTag: 'Data'>

	self assert: self gtExampleContext example subjects first class = GTExampleTagSubject.
	self assert: self gtExampleContext example subjects first theTagName = 'Data'.
	self assert: self gtExampleContext example subjects first theTag notNil.
	self assert: self gtExampleContext example subjects first thePackage notNil.
	self assert: self gtExampleContext example subjects first exists.
	
	^ 0
]

{ #category : #examples }
GTDummyExamplesWithSubjects >> textSubject [
	<gtExample>
	<subjectText: 'Justo Malesuada Bibendum Adipiscing Elit'>
	
	self assert: self gtExampleContext example subjects first class = GTExampleTextSubject.
	self assert: self gtExampleContext example subjects first text = 'Justo Malesuada Bibendum Adipiscing Elit'.
	self assert: self gtExampleContext example subjects first exists.
	
	^ 0
]
