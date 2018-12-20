function* generate(x) {
    const y = 2 * (yield x + 1);
    const z = yield y / 3;
    return x + y + z;
}

const it = generate(5);

console.log(it.next().value);
console.log(it.next(12).value);
console.log(it.next(13).value);