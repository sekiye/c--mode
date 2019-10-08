# -*- mode: snippet -*-
# name: sieve
# key: sieve
# --
vector<bool> is_prime;
vector<bool> is_prime_small;

// エラトステネスの篩 O(n log log n)
vector<ll> sieve(ll n) {
  is_prime.resize(0);
  for (int i = 0; i <= n; i++) {
    is_prime.push_back(true);
  }
  is_prime[0] = is_prime[1] = false;
  vector<ll> prime;
  for (int i = 2; i <= n; i++) {
    if (is_prime[i]) {
      prime.push_back(i);
      for (int j = 2 * i; j <= n; j += i) {
        is_prime[j] = false;
      }
    }
  }
  return prime;
}

// [a, b)の整数に対して篩を行う。is_prime[i - a] = true ⇔ iが素数
void segment_sieve(ll a, ll b) {
  is_prime_small.resize(0);
  for (ll i = 0; i * i < b; i++) {
    is_prime_small.push_back(true);
  }
  is_prime.resize(0);
  for (ll i = 0; i < b - a; i++) {
    is_prime.push_back(true);
  }

  is_prime_small[1] = false;
  if (a == 1) {
    is_prime[0] = false;
  }
  for (ll i = 2; i * i < b; i++) {
    if (is_prime_small[i]) {
      for (ll j = 2 * i; j * j < b; j += i) {
        is_prime_small[j] = false;
      }
      for (ll j = max(2LL, (a + i - 1) / i) * i; j < b; j += i) {
        is_prime[j - a] = false;
      }
    }
  }
}
