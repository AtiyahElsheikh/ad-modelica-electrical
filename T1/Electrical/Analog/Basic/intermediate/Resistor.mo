within ADMSL.T1.Electrical.Analog.Basic.intermediate;
class Resistor "AD version of Modelica.Electrical.Analog.Basic.Resistor"
  extends MSL.Electrical.Analog.Basic.Resistor(
    redeclare replaceable class OnePort =
        Interfaces.OnePort,
    redeclare replaceable class ConditionalHeatPort =
        Interfaces.ConditionalHeatPort0);
  extends ADMSL.Utilities.GradientInfo;

  parameter Real g_R[NG] = zeros(NG) "The gradient of resistance";
  parameter Real g_T_ref[NG] = zeros(NG)
    "The gradient of reference temperature";
  parameter Real g_alpha[NG] = zeros(NG)
    "The gradient of temperature coefficients";

  Real g_R_actual[NG];

protected
  Real T_1111;
  Real g_T_1111[NG];

  Real T_111;
  Real g_T_111[NG];

  Real T_11;
  Real g_T_11[NG];

  Real T_1;
  Real g_T_1[NG];

equation
  T_1111 = T_heatPort - T_ref;
  g_T_1111[1:NG] = g_T_heatPort[1:NG] - g_T_ref[1:NG];

  T_111  = alpha * T_1111;
  g_T_111[1:NG] = g_alpha[1:NG] * T_1111 + alpha * g_T_1111[1:NG];

  T_11   = 1 + T_111;
  g_T_11[1:NG] = g_T_111[1:NG];

  T_1    = R * T_11;
  g_T_1[1:NG] = g_R[1:NG] * T_11 + R * g_T_11[1:NG];

  //R_actual = T_1;
  g_R_actual[1:NG] = g_T_1[1:NG];

  g_v[1:NG] = g_R_actual[1:NG] * i + R_actual * g_i[1:NG];

  g_LossPower[1:NG] = g_v[1:NG] * i + v * g_i[1:NG];

end Resistor;