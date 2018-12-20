let i = 1;
const snooze = seconds => {
    return new Promise( (resolve, reject) => {
        setTimeout(() => {
            resolve(i++)
        }, seconds)
    })
}
const start = process.hrtime()
const ps = Promise.all([
    snooze(2000), snooze(3000), snooze(1000)
]).then(
    r => r.map(q => console.log(q))
)
ps.then(r => {
    const end = process.hrtime()
    console.log(`duration: ${end[0] - start[0]}`)
})


