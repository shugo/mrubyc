/* Auto generated by make_method_table.rb */
#include "symbol_builtin.h"

/*===== Integer class =====*/
static const mrbc_sym method_symbols_Integer[] = {
  MRBC_SYM(MOD),
  MRBC_SYM(AND),
  MRBC_SYM(MUL_MUL),
  MRBC_SYM(PLUS_AT),
  MRBC_SYM(MINUS_AT),
  MRBC_SYM(LT_LT),
  MRBC_SYM(GT_GT),
  MRBC_SYM(BL_BR),
  MRBC_SYM(XOR),
  MRBC_SYM(abs),
#if MRBC_USE_STRING
  MRBC_SYM(chr),
#endif
#if MRBC_USE_STRING
  MRBC_SYM(inspect),
#endif
#if MRBC_USE_FLOAT
  MRBC_SYM(to_f),
#endif
  MRBC_SYM(to_i),
#if MRBC_USE_STRING
  MRBC_SYM(to_s),
#endif
  MRBC_SYM(OR),
  MRBC_SYM(NEG),
};

static const mrbc_func_t method_functions_Integer[] = {
  c_integer_mod,
  c_integer_and,
  c_integer_power,
  c_integer_positive,
  c_integer_negative,
  c_integer_lshift,
  c_integer_rshift,
  c_integer_bitref,
  c_integer_xor,
  c_integer_abs,
#if MRBC_USE_STRING
  c_integer_chr,
#endif
#if MRBC_USE_STRING
  c_integer_to_s,
#endif
#if MRBC_USE_FLOAT
  c_integer_to_f,
#endif
  c_ineffect,
#if MRBC_USE_STRING
  c_integer_to_s,
#endif
  c_integer_or,
  c_integer_not,
};

struct RBuiltinClass mrbc_class_Integer = {
  .sym_id = MRBC_SYM(Integer),
  .num_builtin_method = sizeof(method_symbols_Integer) / sizeof(mrbc_sym),
#if defined(MRBC_DEBUG)
  .names = "Integer",
#endif
  .super = MRBC_CLASS(Object),
  .method_link = 0,
  .method_symbols = method_symbols_Integer,
  .method_functions = method_functions_Integer,
};
