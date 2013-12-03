within ADMSL.Thermal.HeatTransfer.Interfaces;
partial connector HeatPort
  extends Modelica.Thermal.HeatTransfer.Interfaces.HeatPort;
  extends ADMSL.Interfaces.GradientInfo;

  Real g_T[NG] "gradient of port's Temperature";
  flow Real g_Q_flow[NG] "gradient of port's heat flow rate";

end HeatPort;