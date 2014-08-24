# Hubot Diabetes

A diabetes script package for Hubot

[![Build Status](https://travis-ci.org/hubot-scripts/hubot-diabetes.png)](https://travis-ci.org/hubot-scripts/hubot-diabetes)

## Installation

Run `npm install --save hubot-diabetes`

Add **hubot-diabetes** to your `external-scripts.json`:

```json
["hubot-diabetes"]
```

## Sample Interaction
```
<awaxa> 90
<diabot> 90 mg/dL is 5 mmol/L
<awaxa> 5.0
<diabot> 5.0 mmol/L is 90 mg/dL
```

## Sources
[https://github.com/TwelveBaud/diabot-plugins/blob/c99fb2d346ab288ce17944d3d4ea9de0c287f6d2/BGs/plugin.py](https://github.com/TwelveBaud/diabot-plugins/blob/c99fb2d346ab288ce17944d3d4ea9de0c287f6d2/BGs/plugin.py)
[http://professional.diabetes.org/content/PDF/vnzqcAverage%20Glucose%20flyer.pdf](http://professional.diabetes.org/content/PDF/vnzqcAverage%20Glucose%20flyer.pdf)
[http://en.wikipedia.org/w/index.php?title=Glycated_hemoglobin&oldid=618985064#Interpretation_of_results](http://en.wikipedia.org/w/index.php?title=Glycated_hemoglobin&oldid=618985064#Interpretation_of_results)

Many thanks to [JJ Asghar](http://jjasghar.github.io) for all his help and advice!
