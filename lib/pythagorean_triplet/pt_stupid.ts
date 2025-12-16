function findPythagoreanTriplet(sum: number): number {
    for (let a = 1; a < sum; a++) {
        for (let b = a + 1; b < sum; b++) {
            const c = sum - a - b;
            if (c > 0 && a * a + b * b === c * c) {
                return a * b * c;
            }
        }
    }
    return -1;
}

console.log(findPythagoreanTriplet(1000));