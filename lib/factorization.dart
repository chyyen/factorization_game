int countTailZero(int n){
  assert(n > 0);
  int cnt = 0;
  while((n & 1) == 0){
    cnt++;
    n >>= 1;
  }
  return cnt;
}

bool _isPrime(int n, List<int>primes){
  int d = n - 1;
  d >>= countTailZero(d);
  bool result = true;
  for (var p in primes) {
    if(n <= p || result == false){
      continue;
    }
    int t = d, y = 1, b = t;
    while(b > 0) {
      if((b & 1) == 1) {
        y = (y * p) % n;
      }
      p = (p * p) % n;
      b >>= 1;
    }
    while(t != n - 1 && y != 1 && y != n - 1) {
      y = (y * y) % n;
      t <<= 1;
    }
    if(y != n - 1 && t % 2 == 0){
      result = false;
    }
  }
  return result;
}

bool isPrime(int n) {
  if(n % 2 == 0){
    return (n == 2);
  }
  List<int>primes;
  if(n < (1 << 30)){
    primes = [2, 7, 61];
  } else{
    primes = [2, 325, 9375, 28178, 450775, 9780504, 1795265022];
  }
  return _isPrime(n, primes);
}

int _f(int x, int n, int p){
  return (((x * x) % n) + p) % n;
}

void _PollardRho(Map<int, int> mp, int n) {
  if(n == 1){
    return;
  } else if(isPrime(n)){
    mp[n] = (mp[n] == null ? 1 : mp[n]! + 1);
    return;
  } else if(n % 2 == 0){
    mp[2] = (mp[2] == null ? 1 : mp[2]! + 1);
    _PollardRho(mp, n ~/ 2);
    return;
  }
  int x = 2, y = 2, d = 1, p = 1;
  while(true){
    if(d != 1 && d != n){
      _PollardRho(mp, d);
      _PollardRho(mp, n ~/ d);
      return;
    }
    p += (d == n ? 1 : 0);
    x = _f(x, n, p);
    y = _f(_f(y, n, p), n, p);
    d = n.gcd((x- y).abs());
  }
}

Map<int, int>getPrimeDivisor(int n){
  assert(n > 0);
  Map<int, int>mp = {};
  _PollardRho(mp, n);
  return mp;
}