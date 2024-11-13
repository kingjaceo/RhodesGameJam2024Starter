extends Node
'''https://github.com/TheFamousRat/GodotUtility/blob/master/nodes/Random.gd'''

#Collection of functions returning a value obtained from a random variable following a certain distribution
#All the currently impletemented functions are quick, the results being given by quick tests or "good enough" estimates
#Feel free to suggest or pull request some other distributions !

#Returns a value from a uniform distribution
#Parameters are the interval. Value has an equal chance to take any value of this interval
func uniform(min_ : float = 0.0, max_ : float = 1.0, continuous : bool = true):
	if continuous:
		return randf_range(min_,max_)
	else:
		return int(min_) + randi()%(int(max_) - int(min_) + 1)

func chi2(degOfFreedom : int) -> float:
	var sum : float = 0.0
	for i in range(0,degOfFreedom):
		sum += pow(normal(0.0,1.0),2.0)
	return sum

#1 or 0
func bernoulli(prob : float) -> int:
	return int(randf() < prob)

func binomial(tries : int, prob : float, simulated : bool):
	if tries < 100 or simulated:
		var acc : int = 0
		for i in range(0,tries):
			acc += bernoulli(prob)
		return acc
	else:
		return int(round(abs(normal(tries*prob,tries*prob*(1.0-prob)))))

func exponential(param : float = 1.0) -> float:
	return ln(1.0 - randf())/(-param)

#Returns a value from a variable following a random gaussian distribution.
#Parameters are average and standard deviation
func normal(avg : float = 0.0, sd : float = 1.0) -> float:
	return avg+sd*sqrt(-2*(ln(randf())))*cos(2*PI*randf())

func geometric(prob : float) -> int:
	return int(ln(1-randf())/ln(1-prob))

#Natural logarithm
func ln(arg : float) -> float:
	return log(arg)/log(exp(1))
