/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.apache.linkis.cli.core.interactor.job;

import org.apache.linkis.cli.common.entity.command.CmdType;
import org.apache.linkis.cli.common.entity.job.JobData;
import org.apache.linkis.cli.common.entity.job.JobDescription;
import org.apache.linkis.cli.common.entity.job.JobSubType;
import org.apache.linkis.cli.common.entity.operator.JobOperator;
import org.apache.linkis.cli.common.entity.present.PresentWay;
import org.apache.linkis.cli.core.builder.BuildableByVarAccess;

public abstract class JobBuilder extends BuildableByVarAccess<AbstractJob> {

  public JobBuilder setCid(String cid) {
    targetObj.setCid(cid);
    return this;
  }

  public JobBuilder setCmdType(CmdType cmdType) {
    targetObj.setCmdType(cmdType);
    return this;
  }

  public JobBuilder setJobSubType(JobSubType subType) {
    targetObj.setSubType(subType);
    return this;
  }

  protected abstract JobDescription buildJobDesc();

  protected abstract JobData buildJobData();

  protected abstract JobOperator buildJobOperator();

  protected abstract PresentWay buildPresentWay();
}
