using Dtm.Framework.ClientSites.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SJOXTREAM.PageHandlers
{
    public class CommonPageHandler : PageHandler
    {
        public static List<string> MainProductCodes { get; set; }
        public static string MainCode { get; set; }
        public static string AffirmPrefix { get; set; }
        public CommonPageHandler()
        {
            AffirmPrefix = "AFF";

            var version = (int)DtmContext.Version;
            switch (version)
            {
                case 2:
                case 4:
                    MainCode = "MAINC";
                    break;
                case 3:
                    MainCode = "MAINC10";
                    break;
                case 5:
                    MainCode = "MAINTV,MAINMP,MAINBV";
                    break;
                case 7:
                    MainCode = "MAINTV,MAINMP2,MAINBV2";
                    break;
                case 8:
                    MainCode = "MAINTVDIS,MAINMPDIS,MAINBVDIS";
                    break;
                case 9:
                    MainCode = "MAINTV,MAINMP3,MAINBV3";
                    break;
                case 10:
                    MainCode = "MAINTVDIS,MAINMPDIS3,MAINBVDIS3";
                    break;
                case 13:
                case 14:
                    MainCode = "MAINTVLOW,MAINMP3LOW,MAINBV3LOW";
                    break;
                case 15:
                    MainCode = "MAINTVLOW,MAINMP4LOW,MAINBV4LOW";
                    break;

                default:

                    MainCode = "MAINA";

                    break;
            }

            MainProductCodes = new List<string>() { MainCode, AffirmPrefix + MainCode };
        }

    }
}