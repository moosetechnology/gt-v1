Class {
	#name : #BaselineOfGTPlayground,
	#superclass : #BaselineOf,
	#category : #BaselineOfGTPlayground
}

{ #category : #baselines }
BaselineOfGTPlayground >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'GTPlaygroundCore' with: [ 
				spec repository: 'github://moosetechnology/gt-v1/src' ];
			baseline: 'GTInspector' with: [ 
				spec repository: 'github://moosetechnology/gt-v1/src' ] ]
]
