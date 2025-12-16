function sumDivisors(n: number): number {
    let sum = 0;
    for (let i = 1; i <= Math.sqrt(n); i++) {
        if (n % i === 0) {
            sum += i;
            if (i !== 1 && i !== n / i) {
                sum += n / i;
            }
        }
    }
    return sum;
}

function isAmicable(n: number): boolean {
    const b = sumDivisors(n);
    return b !== n && sumDivisors(b) === n;
}

function amicableNumbersSum(limit: number): number {
    let sum = 0;
    for (let i = 2; i < limit; i++) {
        if (isAmicable(i)) {
            sum += i;
        }
    }
    return sum;
}

console.log(amicableNumbersSum(10000));