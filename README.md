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
<awaxa> i was _90_ this morning
<diabot> 90 mg/dL is 5 mmol/L
<awaxa> i was _5.0_ this morning
<diabot> 5.0 mmol/L is 90 mg/dL
<awaxa> diabot: estimate a1c from average 90
<diabot> an average of 90 mg/dL or 5.0 mmol/L is about 4.8% (DCCT) or 29 mmol/mol (IFCC)
<awaxa> diabot: estimate a1c from average 5.0
<diabot> an average of 90 mg/dL or 5.0 mmol/L is about 4.8% (DCCT) or 29 mmol/mol (IFCC)
<awaxa> diabot: estimate average from a1c 4.8
<diabot> an A1C of 4.8% (DCCT) or 29 mmol/mol (IFCC) is about 91 mg/dL or 5.1 mmol/L
<awaxa> diabot: estimate average from a1c 29
<diabot> an A1C of 4.8% (DCCT) or 29 mmol/mol (IFCC) is about 91 mg/dL or 5.1 mmol/L

```

## Sources
* [TwelveBaud/diabot-plugins](https://github.com/TwelveBaud/diabot-plugins/blob/c99fb2d346ab288ce17944d3d4ea9de0c287f6d2/BGs/plugin.py)
* [ADA average glucose estimation](http://professional.diabetes.org/content/PDF/vnzqcAverage%20Glucose%20flyer.pdf)
* [Wikipedia: Glycated hemoglobin](http://en.wikipedia.org/w/index.php?title=Glycated_hemoglobin&oldid=618985064#Interpretation_of_results)

Many thanks to [JJ Asghar](http://jjasghar.github.io) for all his help and advice!
